//
//  NetworkManager.swift
//  TakeHomeProject-Ordering-App
//
//  Created by Ikmal Azman on 28/06/2022.
//

import Foundation

class NetworkManager {
    
    var dataTask : URLSessionDataTask?
    var urlSession = URLSession.shared
    
    func requestAPI(for endpoint : APIEndpoint,completion : @escaping ((Result<OrdersResponse, APIError>)->Void)) {
        guard let url = URL(string: endpoint.rawValue) else {
            return
        }
        
        let request = URLRequest(url: url)
        
        dataTask = urlSession.dataTask(with: request) { data, response, error in
            if let _ = error {
                completion(.failure(.opsAPIError))
                return
            }
            
            guard let data = data else {
                completion(.failure(.opsAPIError))
                return
            }
            
            do {
                let decoder = JSONDecoder()
                decoder.keyDecodingStrategy = .convertFromSnakeCase
                
                let object = try decoder.decode(OrdersResponse.self, from: data)
                print(object)
                completion(.success(object))
            } catch {
                completion(.failure(.opsAPIError))
            }
        }
        dataTask?.resume()
    }
}

enum APIEndpoint : String {
    case listOfOrders = "http://staging-api.dahmakan.com/test/orders"
}

enum APIError : String, Error {
    case opsAPIError = "Ops there something wrong with our server"
}
