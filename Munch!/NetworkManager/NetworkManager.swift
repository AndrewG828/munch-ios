//
//  NetworkManager.swift
//  Munch!
//
//  Created by Andrew Gao on 5/1/25.
//

import Alamofire
import Foundation
import UIKit

class NetworkManager {
    static let shared = NetworkManager()
    
    private init() {
        
    }
    
    private let mainUrl = "http://10.48.129.73:5001/api"
    
    let decoder = JSONDecoder()
    
    func createUser(credentials: UserCredentials, completion: @escaping (Result<User, Error>) -> Void) {
        let endpoint = mainUrl + "/users/"

        AF.request(endpoint, method: .post, parameters: credentials, encoder: JSONParameterEncoder.default)
            .validate()
            .responseDecodable(of: User.self) { response in
                switch response.result {
                case .success(let user):
                    completion(.success(user))
                case .failure(let error):
                    print("Create user failed: \(error.localizedDescription)")
                    completion(.failure(error))
                }
            }
    }
    
    func getAllFood(completion: @escaping ([Food]) -> Void) {
        let endpoint = mainUrl + "/food/"
        
        AF.request(endpoint, method: .get)
            .validate()
            .responseDecodable(of: FoodListResponse.self, decoder: decoder) {
                response in
                switch response.result {
                case .success(let foods):
                    completion(foods.foodItems)
                case .failure(let error):
                    print("Error getting all foods \(error.localizedDescription)")
                    completion([])
                }
            }
    }
    
    func scrapeReceipt(image: UIImage, completion: @escaping (ReceiptResponse?) -> Void) {
        let endpoint = mainUrl + "/receipts/"
        
        guard let imageData = image.jpegData(compressionQuality: 0.8) else {
            print("Failed to convert UIImage to JPEG")
            completion(nil)
            return
        }

        AF.upload(multipartFormData: { form in
            form.append(imageData, withName: "image", fileName: "receipt.jpg", mimeType: "image/jpeg")
        }, to: endpoint)
        .validate()
        .responseDecodable(of: ReceiptResponse.self) { response in
            switch response.result {
            case .success(let receiptResponse):
                completion(receiptResponse)
            case .failure(let error):
                print("Error in scraping receipt: \(error.localizedDescription)")
                if let data = response.data,
                   let raw = String(data: data, encoding: .utf8) {
                    print("Server response:\n\(raw)")
                }
                completion(nil)
            }
        }
    }
    
    func fetchCategories(completion: @escaping (CategoryResponse?) -> Void) {
        let endpoint = mainUrl + "/food/categories/"
        
        AF.request(endpoint, method: .get)
            .validate()
            .responseDecodable(of: CategoryResponse.self, decoder: decoder) { response in
                switch response.result {
                case .success(let categories):
                    completion(categories)
                case .failure(let error):
                    print("Error fetching all categories \(error.localizedDescription)")
                    if let data = response.data,
                        let raw = String(data: data, encoding: .utf8) {
                            print("Raw server response:\n\(raw)")
                        }
                    completion(nil)
                }
            }
    }
    
    func getAllFoodByCategory(category: String, completion: @escaping ([Food]) -> Void) {
        let endpoint = mainUrl + "/\(category)/foods/"
        
        AF.request(endpoint, method: .get)
            .validate()
            .responseDecodable(of: FoodListResponse.self, decoder: decoder) {
                response in
                switch response.result {
                case .success(let foods):
                    completion(foods.foodItems)
                case .failure(let error):
                    print("Error getting all foods \(error.localizedDescription)")
                    completion([])
                }
            }
    }
    
    func postReview(review: ReviewRequest, completion: @escaping (Bool) -> Void) {
            let endpoint = mainUrl + "/food/reviews/"

            AF.request(endpoint,
                       method: .post,
                       parameters: review,
                       encoder: JSONParameterEncoder.default)
                .validate()
                .response { response in
                    switch response.result {
                    case .success:
                        completion(true)
                    case .failure(let error):
                        print("Error posting review: \(error.localizedDescription)")
                        completion(false)
                    }
                }
        }
    
    func getReviewsForFood(foodId: Int, completion: @escaping ([Review]) -> Void) {
        let endpoint = mainUrl + "/food/\(foodId)/reviews/"

        AF.request(endpoint, method: .get)
            .validate()
            .responseDecodable(of: [Review].self, decoder: decoder) { response in
                switch response.result {
                case .success(let reviews):
                    completion(reviews)
                case .failure(let error):
                    print("Error getting reviews for food \(foodId): \(error.localizedDescription)")
                    completion([])
                }
            }
    }
    
    func getAllRestaurants(completion: @escaping ([Restaurant]) -> Void) {
        let endpoint = mainUrl + "/restaurants/"

        AF.request(endpoint)
            .validate()
            .responseDecodable(of: RestaurantHelper.self, decoder: decoder) { response in
                switch response.result {
                case .success(let data):
                    completion(data.restaurants)
                case .failure(let error):
                    print("Error fetching restaurants:", error.localizedDescription)
                    if let data = response.data,
                        let raw = String(data: data, encoding: .utf8) {
                            print("Raw server response:\n\(raw)")
                        }
                    completion([])
                }
            }
    }
    
    func sendVenmoRequest(userId: Int, recipientUsername: String, paymentAmount: Double, message: String, completion: @escaping (String?) -> Void) {
        let endpoint = mainUrl + "/payment/\(userId)/"

        let parameters: [String: Any] = [
            "recipient_username": recipientUsername,
            "payment_amount": paymentAmount,
            "message": message
        ]

        AF.request(endpoint, method: .post, parameters: parameters, encoding: JSONEncoding.default)
            .validate()
            .responseJSON { response in
                switch response.result {
                case .success(let value):
                    if let dict = value as? [String: Any],
                       let link = dict["payment_link"] as? String {
                        completion(link)
                    } else {
                        print("Error: payment_link not found in response.")
                        completion(nil)
                    }
                case .failure(let error):
                    print("Error sending Venmo request: \(error.localizedDescription)")
                    if let data = response.data,
                       let raw = String(data: data, encoding: .utf8) {
                        print("Raw server response:\n\(raw)")
                    }
                    completion(nil)
                }
            }
    }

}

