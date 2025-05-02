//
//  Receipt.swift
//  Munch!
//
//  Created by Andrew Gao on 5/2/25.
//

import Foundation

struct ReceiptItem: Codable, Hashable {
    var id: Int
    var name: String
    var price: Float
}

struct ReceiptResponse: Hashable, Codable {
    var items: [ReceiptItem]
    var paymentTotal: Float
    var tax: Float
    var tips: Float
    var storeName: String
    enum CodingKeys: String, CodingKey {
        case items
        case paymentTotal = "payment_total"
        case tax
        case tips
        case storeName = "store_name"
    }
}

extension ReceiptItem {
//    static let dummyData = [
//        ReceiptItem(id: 1, name: "Summer Rolls", price: 15.00, assignFriends: []),
//        ReceiptItem(id: 2, name: "House Pho 1", price: 15.00, assignFriends: []),
//        ReceiptItem(id: 3, name: "House Pho 1", price: 15.00, assignFriends: []),
//        ReceiptItem(id: 4, name: "House Pho 2", price: 15.00, assignFriends: []),
//        ReceiptItem(id: 5, name: "Chicken Wings", price: 15.00, assignFriends: []),
//        
//    ]
}
