//
//  RestaurantViewModel.swift
//  Munch!
//
//  Created by Andrew Gao on 5/2/25.
//

import SwiftUI

class RestaurantViewModel: ObservableObject {
    @Published var restaurants: [Restaurant] = []

    func fetchRestaurants() {
        NetworkManager.shared.getAllRestaurants { [weak self] list in
            guard let self = self else {return}
            DispatchQueue.main.async {
                self.restaurants = list
            }
        }
    }
}
