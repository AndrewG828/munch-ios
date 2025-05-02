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

    func getAllFoods() {
        NetworkManager.shared.getAllFood { [weak self] foodList in
            guard let self = self else {return}
            
            DispatchQueue.main.async {
                self.foods = foodList
            }
        }
    }
}
