//
//  NetworkManager.swift
//  Munch!
//
//  Created by Andrew Gao on 5/1/25.
//

import Alamofire
import Foundation

class NetworkManager {
    static let shared = NetworkManager()
    
    private init() {
        
    }
    
    private let mainUrl = "http://10.48.129.73:5001/api"
    
    let decoder = JSONDecoder()
    
    func createUser(credentials: UserCredentials, completion: @escaping (Result<User, Error>) -> Void) {
        let endpoint = mainUrl + "/users/"

        AF.request(endpoint, method: .post, parameters: credentials, encoder: JSONParameterEncoder.default)
            .validate()
            .responseDecodable(of: User.self) { response in
                switch response.result {
                case .success(let user):
                    completion(.success(user))
                case .failure(let error):
                    print("Create user failed: \(error.localizedDescription)")
                    completion(.failure(error))
                }
            }
    }
}

