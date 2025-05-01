//
//  User.swift
//  Munch!
//
//  Created by Andrew Gao on 5/1/25.
//
import Foundation

struct User: Hashable, Codable {
    var id: Int
    var username: String
    var email: String
    var phone: Int
    var venmo: String
//    var foods: [Food]
//    var favorites: [Food]
//    var reviews: [Review]
}

struct UserCredentials: Codable {
    var username: String
    var password: String
}
