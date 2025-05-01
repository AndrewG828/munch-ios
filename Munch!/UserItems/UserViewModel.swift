//
//  ViewModel.swift
//  Munch!
//
//  Created by Andrew Gao on 5/1/25.
//

import SwiftUI


class UserViewModel: ObservableObject {
    // MARK: - Published Properties
    @Published var username: String = ""
    @Published var password: String = ""
    @Published var user: User? = nil

    // MARK: - API Call
    func createUser(onSuccess: (() -> Void)? = nil) {

        let credentials = UserCredentials(username: username, password: password)

        NetworkManager.shared.createUser(credentials: credentials) { [weak self] result in
            guard let self = self else {return}
            
            DispatchQueue.main.async {
                switch result {
                case .success(let user):
                    self.user = user
                    onSuccess?()
                case .failure(let error):
                    print("User creation failed:", error.localizedDescription)
                }
            }
        }
    }
}

