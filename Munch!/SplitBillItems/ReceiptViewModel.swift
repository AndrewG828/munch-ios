//
//  ReceiptViewModel.swift
//  Munch!
//
//  Created by Andrew Gao on 5/2/25.
//

import SwiftUI
import Foundation
import UIKit

class ReceiptViewModel: ObservableObject {
    @Published var splitFoods: [ReceiptItem] = []
    @Published var tax: Float = 0
    @Published var tips: Float = 0
    @Published var paymentTotal: Float = 0
    @Published var receiptImage: UIImage? = nil
    @Published var isLoading = false
    
    func scrapeReceipt() {
        guard let image = receiptImage else {
            print("No image to scrape.")
            return
        }
        isLoading = true
        
        NetworkManager.shared.scrapeReceipt(image: image) { [weak self] receipt in
            guard let self = self else {return}
            if let receipt = receipt {
                DispatchQueue.main.async {
                    self.splitFoods = receipt.items
                    self.tax = receipt.tax
                    self.tips = receipt.tips
                    self.paymentTotal = receipt.paymentTotal
                    self.isLoading = false
                }
            }
        }
    }
}
