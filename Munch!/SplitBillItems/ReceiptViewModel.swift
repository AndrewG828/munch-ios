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
    @Published var receiptImage: UIImage? = nil
    @Published var isLoading = false
    
    func scrapeReceipt() {
        guard let image = receiptImage else {
            print("No image to scrape.")
            return
        }
        isLoading = true
        
        NetworkManager.shared.scrapeReceipt(image: image) { [weak self] items in
            guard let self = self else {return}
            DispatchQueue.main.async {
                self.splitFoods = items
                self.isLoading = false
            }
        }
    }
}
