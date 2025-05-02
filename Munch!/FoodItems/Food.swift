//
//  Food.swift
//  Munch!
//
//  Created by Andrew Gao on 4/30/25.
//

import Foundation

struct Food: Hashable, Identifiable, Codable {
    var id: Int
    var name: String
    var price: Float
    var category: String
    var imageUrl: String
    var rating: Float
    var restaurant: RestaurantResponse
    enum CodingKeys: String, CodingKey {
        case id
        case name
        case price
        case category
        case imageUrl = "image_url"
        case rating = "avg_rating"
        case restaurant
    }
}

struct FoodListResponse: Codable {
    let foodItems: [Food]

    enum CodingKeys: String, CodingKey {
        case foodItems = "food items"
    }
}

extension Food {
//    static let dummyData = [
//        Food(id: 1, name: "Cajun Fries", price: 3.65, category: "Fries", imageUrl: "https://cdn.apartmenttherapy.info/image/upload/f_auto,q_auto:eco,c_fill,g_auto,w_1456,h_1092/k%2FPhoto%2FRecipes%2F2023-11-cajun-fries%2F32989-Cajun-fries-1", rating: 9.6, restaurantId: [1]),
//        Food(id: 2, name: "Cajun Fries", price: 3.65, category: "Fries", imageUrl: "https://cdn.apartmenttherapy.info/image/upload/f_auto,q_auto:eco,c_fill,g_auto,w_1456,h_1092/k%2FPhoto%2FRecipes%2F2023-11-cajun-fries%2F32989-Cajun-fries-1", rating: 9.6, restaurantId: [1]),
//        Food(id: 3, name: "Cajun Fries", price: 3.65, category: "Fries", imageUrl: "https://cdn.apartmenttherapy.info/image/upload/f_auto,q_auto:eco,c_fill,g_auto,w_1456,h_1092/k%2FPhoto%2FRecipes%2F2023-11-cajun-fries%2F32989-Cajun-fries-1", rating: 9.6, restaurantId: [1]),
//        Food(id: 4, name: "Cajun Fries", price: 3.65, category: "Fries", imageUrl: "https://cdn.apartmenttherapy.info/image/upload/f_auto,q_auto:eco,c_fill,g_auto,w_1456,h_1092/k%2FPhoto%2FRecipes%2F2023-11-cajun-fries%2F32989-Cajun-fries-1", rating: 9.6, restaurantId: [1]),
//        Food(id: 5, name: "Cajun Fries", price: 3.65, category: "Fries", imageUrl: "https://cdn.apartmenttherapy.info/image/upload/f_auto,q_auto:eco,c_fill,g_auto,w_1456,h_1092/k%2FPhoto%2FRecipes%2F2023-11-cajun-fries%2F32989-Cajun-fries-1", rating: 9.6, restaurantId: [1]),
//        Food(id: 6, name: "Cajun Fries", price: 3.65, category: "Fries", imageUrl: "https://cdn.apartmenttherapy.info/image/upload/f_auto,q_auto:eco,c_fill,g_auto,w_1456,h_1092/k%2FPhoto%2FRecipes%2F2023-11-cajun-fries%2F32989-Cajun-fries-1", rating: 9.6, restaurantId: [1]),
//        Food(id: 7, name: "Cajun Fries", price: 3.65, category: "Fries", imageUrl: "https://cdn.apartmenttherapy.info/image/upload/f_auto,q_auto:eco,c_fill,g_auto,w_1456,h_1092/k%2FPhoto%2FRecipes%2F2023-11-cajun-fries%2F32989-Cajun-fries-1", rating: 9.6, restaurantId: [1])
//    ]
}
