//
//  FoodViewController.swift
//  Munch!
//
//  Created by Andrew Gao on 5/2/25.
//

import SwiftUI
import Foundation

class FoodViewModel: ObservableObject {
    @Published var foods: [Food] = []
    
    @Published var categoryFoods: [Food] = []
    
    @Published var category = ""

    func getAllFoods() {
        NetworkManager.shared.getAllFood { [weak self] foodList in
            guard let self = self else {return}
            
            DispatchQueue.main.async {
                self.foods = foodList
            }
        }
    }
    
    func getAllFoodsByCategory(selectedCategory: String) {
        category = selectedCategory
        
        NetworkManager.shared.getAllFoodByCategory(category: category) { [weak self] foodList in
            guard let self = self else {return}
            
            DispatchQueue.main.async {
                self.categoryFoods = foodList
            }
        }
    }
}
