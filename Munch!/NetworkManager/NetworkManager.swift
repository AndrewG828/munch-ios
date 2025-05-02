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
    
    func scrapeReceipt(image: UIImage, completion: @escaping ([ReceiptItem]) -> Void) {
        let endpoint = mainUrl + "/receipts/"
        
        guard let imageData = image.jpegData(compressionQuality: 0.8) else {
            print("Failed to convert UIImage to JPEG")
            completion([])
            return
        }

        AF.upload(multipartFormData: { form in
            form.append(imageData, withName: "image", fileName: "receipt.jpg", mimeType: "image/jpeg")
        }, to: endpoint)
        .validate()
        .responseDecodable(of: ReceiptResponse.self) { response in
            switch response.result {
            case .success(let receiptResponse):
                completion(receiptResponse.items)
            case .failure(let error):
                print("Error in scraping receipt: \(error.localizedDescription)")
                if let data = response.data,
                   let raw = String(data: data, encoding: .utf8) {
                    print("Server response:\n\(raw)")
                }
                completion([])
            }
        }
    }

}

