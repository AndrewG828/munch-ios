//
//  Review.swift
//  Munch!
//
//  Created by Andrew Gao on 5/1/25.
//

import Foundation

struct Review: Hashable, Identifiable {
    var id: Int
    var username: String
    var review: String
    var rating: Float
    var profileImage: String
//    var foodItem: String
//    var foodUrl: String
}

extension Review {
//    static let dummyData = [
//        Review(id: 1, username: "Fanhao", review: "I love these cajun fries and they are so good I will eat them everyday after I come back from class!", rating: 8.2, profileImage: "Google", foodItem: "Cajun Fries", foodUrl: "https://cdn.apartmenttherapy.info/image/upload/f_auto,q_auto:eco,c_fill,g_auto,w_1456,h_1092/k%2FPhoto%2FRecipes%2F2023-11-cajun-fries%2F32989-Cajun-fries-1"),
//        Review(id: 2, username: "Fanhao", review: "I love these cajun fries and they are so good I will eat them everyday after I come back from class!", rating: 8.2, profileImage: "Google", foodItem: "Cajun Fries", foodUrl: "https://cdn.apartmenttherapy.info/image/upload/f_auto,q_auto:eco,c_fill,g_auto,w_1456,h_1092/k%2FPhoto%2FRecipes%2F2023-11-cajun-fries%2F32989-Cajun-fries-1"),
//        Review(id: 3, username: "Fanhao", review: "I love these cajun fries and they are so good I will eat them everyday after I come back from class!", rating: 8.2, profileImage: "Google", foodItem: "Cajun Fries", foodUrl: "https://cdn.apartmenttherapy.info/image/upload/f_auto,q_auto:eco,c_fill,g_auto,w_1456,h_1092/k%2FPhoto%2FRecipes%2F2023-11-cajun-fries%2F32989-Cajun-fries-1"),
//        Review(id: 4, username: "Fanhao", review: "I love these cajun fries and they are so good I will eat them everyday after I come back from class!", rating: 8.2, profileImage: "Google", foodItem: "Cajun Fries", foodUrl: "https://cdn.apartmenttherapy.info/image/upload/f_auto,q_auto:eco,c_fill,g_auto,w_1456,h_1092/k%2FPhoto%2FRecipes%2F2023-11-cajun-fries%2F32989-Cajun-fries-1"),
//        Review(id: 5, username: "Fanhao", review: "I love these cajun fries and they are so good I will eat them everyday after I come back from class!", rating: 8.2, profileImage: "Google", foodItem: "Cajun Fries", foodUrl: "https://cdn.apartmenttherapy.info/image/upload/f_auto,q_auto:eco,c_fill,g_auto,w_1456,h_1092/k%2FPhoto%2FRecipes%2F2023-11-cajun-fries%2F32989-Cajun-fries-1"),
//        Review(id: 6, username: "Fanhao", review: "I love these cajun fries and they are so good I will eat them everyday after I come back from class!", rating: 8.2, profileImage: "Google", foodItem: "Cajun Fries", foodUrl: "https://cdn.apartmenttherapy.info/image/upload/f_auto,q_auto:eco,c_fill,g_auto,w_1456,h_1092/k%2FPhoto%2FRecipes%2F2023-11-cajun-fries%2F32989-Cajun-fries-1"),
//        Review(id: 7, username: "Fanhao", review: "I love these cajun fries and they are so good I will eat them everyday after I come back from class!", rating: 8.2, profileImage: "Google", foodItem: "Cajun Fries", foodUrl: "https://cdn.apartmenttherapy.info/image/upload/f_auto,q_auto:eco,c_fill,g_auto,w_1456,h_1092/k%2FPhoto%2FRecipes%2F2023-11-cajun-fries%2F32989-Cajun-fries-1"),
//        Review(id: 8, username: "Fanhao", review: "I love these cajun fries and they are so good I will eat them everyday after I come back from class!", rating: 8.2, profileImage: "Google", foodItem: "Cajun Fries", foodUrl: "https://cdn.apartmenttherapy.info/image/upload/f_auto,q_auto:eco,c_fill,g_auto,w_1456,h_1092/k%2FPhoto%2FRecipes%2F2023-11-cajun-fries%2F32989-Cajun-fries-1")
//    ]
    static let dummyData = [
        Review(id: 1, username: "Fanhao", review: "I love these cajun fries and they are so good I will eat them everyday after I come back from class!", rating: 1.2, profileImage: "Google"),
        Review(id: 2, username: "Fanhao", review: "I love these cajun fries and they are so good I will eat them everyday after I come back from class!", rating: 8.2, profileImage: "Google"),
        Review(id: 3, username: "Fanhao", review: "I love these cajun fries and they are so good I will eat them everyday after I come back from class!", rating: 8.2, profileImage: "Google"),
        Review(id: 4, username: "Fanhao", review: "I love these cajun fries and they are so good I will eat them everyday after I come back from class!", rating: 8.2, profileImage: "Google"),
        Review(id: 5, username: "Fanhao", review: "I love these cajun fries and they are so good I will eat them everyday after I come back from class!", rating: 8.2, profileImage: "Google"),
        Review(id: 6, username: "Fanhao", review: "I love these cajun fries and they are so good I will eat them everyday after I come back from class!", rating: 8.2, profileImage: "Google"),
        Review(id: 7, username: "Fanhao", review: "I love these cajun fries and they are so good I will eat them everyday after I come back from class!", rating: 8.2, profileImage: "Google"),
        Review(id: 8, username: "Fanhao", review: "I love these cajun fries and they are so good I will eat them everyday after I come back from class!", rating: 8.2, profileImage: "Google")
    ]
}
