//
//  Restaurant.swift
//  Munch!
//
//  Created by Andrew Gao on 4/30/25.
//
import Foundation

struct Restaurant: Hashable, Identifiable {
    var id: Int
    var name: String
    var address: String
    var imageUrl: String
    var menu: [Food]
}

extension Restaurant {
    static let dummyData = [
        Restaurant(id: 1, name: "Louie's Lunch", address: "1101 Ithaca Street", imageUrl: "https://images.squarespace-cdn.com/content/v1/652acd9b17964c6dee342618/758a791f-d91a-4ea3-aa73-067d4b57cb59/louies_wiki.jpg?format=2500w", menu: [Food(id: 1, name: "Cajun Fries", price: 3.65, category: "Fries", imageUrl: "https://cdn.apartmenttherapy.info/image/upload/f_auto,q_auto:eco,c_fill,g_auto,w_1456,h_1092/k%2FPhoto%2FRecipes%2F2023-11-cajun-fries%2F32989-Cajun-fries-1", rating: 9.6, restaurantId: [1])]),
        Restaurant(id: 2, name: "Louie's Lunch", address: "1101 Ithaca Street", imageUrl: "https://images.squarespace-cdn.com/content/v1/652acd9b17964c6dee342618/758a791f-d91a-4ea3-aa73-067d4b57cb59/louies_wiki.jpg?format=2500w", menu: [Food(id: 1, name: "Cajun Fries", price: 3.65, category: "Fries", imageUrl: "https://cdn.apartmenttherapy.info/image/upload/f_auto,q_auto:eco,c_fill,g_auto,w_1456,h_1092/k%2FPhoto%2FRecipes%2F2023-11-cajun-fries%2F32989-Cajun-fries-1", rating: 9.6, restaurantId: [1])]),
        Restaurant(id: 3, name: "Louie's Lunch", address: "1101 Ithaca Street", imageUrl: "https://images.squarespace-cdn.com/content/v1/652acd9b17964c6dee342618/758a791f-d91a-4ea3-aa73-067d4b57cb59/louies_wiki.jpg?format=2500w", menu: [Food(id: 1, name: "Cajun Fries", price: 3.65, category: "Fries", imageUrl: "https://cdn.apartmenttherapy.info/image/upload/f_auto,q_auto:eco,c_fill,g_auto,w_1456,h_1092/k%2FPhoto%2FRecipes%2F2023-11-cajun-fries%2F32989-Cajun-fries-1", rating: 9.6, restaurantId: [1])]),
        Restaurant(id: 4, name: "Louie's Lunch", address: "1101 Ithaca Street", imageUrl: "https://images.squarespace-cdn.com/content/v1/652acd9b17964c6dee342618/758a791f-d91a-4ea3-aa73-067d4b57cb59/louies_wiki.jpg?format=2500w", menu: [Food(id: 1, name: "Cajun Fries", price: 3.65, category: "Fries", imageUrl: "https://cdn.apartmenttherapy.info/image/upload/f_auto,q_auto:eco,c_fill,g_auto,w_1456,h_1092/k%2FPhoto%2FRecipes%2F2023-11-cajun-fries%2F32989-Cajun-fries-1", rating: 9.6, restaurantId: [1])]),
        Restaurant(id: 5, name: "Louie's Lunch", address: "1101 Ithaca Street", imageUrl: "https://images.squarespace-cdn.com/content/v1/652acd9b17964c6dee342618/758a791f-d91a-4ea3-aa73-067d4b57cb59/louies_wiki.jpg?format=2500w", menu: [Food(id: 1, name: "Cajun Fries", price: 3.65, category: "Fries", imageUrl: "https://cdn.apartmenttherapy.info/image/upload/f_auto,q_auto:eco,c_fill,g_auto,w_1456,h_1092/k%2FPhoto%2FRecipes%2F2023-11-cajun-fries%2F32989-Cajun-fries-1", rating: 9.6, restaurantId: [1])])
    ]
}
