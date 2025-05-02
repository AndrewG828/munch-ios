//
//  Restaurant.swift
//  Munch!
//
//  Created by Andrew Gao on 4/30/25.
//
import Foundation

struct Restaurant: Hashable, Identifiable, Codable {
    var id: Int
    var name: String
    var address: String
    var imageUrl: String
    var menu: [Food]
}

struct RestaurantResponse: Hashable, Identifiable, Codable {
    var id: Int
    var name: String
    var address: String
}

extension Restaurant {
    static let dummyData = [
        Restaurant(id: 1, name: "Louie's Lunch", address: "1101 Ithaca Street", imageUrl: "https://images.squarespace-cdn.com/content/v1/652acd9b17964c6dee342618/758a791f-d91a-4ea3-aa73-067d4b57cb59/louies_wiki.jpg?format=2500w", menu: []),
        Restaurant(id: 2, name: "Louie's Lunch", address: "1101 Ithaca Street", imageUrl: "https://images.squarespace-cdn.com/content/v1/652acd9b17964c6dee342618/758a791f-d91a-4ea3-aa73-067d4b57cb59/louies_wiki.jpg?format=2500w", menu: []),
        Restaurant(id: 3, name: "Louie's Lunch", address: "1101 Ithaca Street", imageUrl: "https://images.squarespace-cdn.com/content/v1/652acd9b17964c6dee342618/758a791f-d91a-4ea3-aa73-067d4b57cb59/louies_wiki.jpg?format=2500w", menu: []),
        Restaurant(id: 4, name: "Louie's Lunch", address: "1101 Ithaca Street", imageUrl: "https://images.squarespace-cdn.com/content/v1/652acd9b17964c6dee342618/758a791f-d91a-4ea3-aa73-067d4b57cb59/louies_wiki.jpg?format=2500w", menu: []),
        Restaurant(id: 5, name: "Louie's Lunch", address: "1101 Ithaca Street", imageUrl: "https://images.squarespace-cdn.com/content/v1/652acd9b17964c6dee342618/758a791f-d91a-4ea3-aa73-067d4b57cb59/louies_wiki.jpg?format=2500w", menu: [])
    ]
}
