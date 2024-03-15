//
//  NetworkManager.swift
//  ShopSwift
//
//  Created by Şükrü Şimşek on 14.03.2024.
//

import Foundation

class NetworkManager {
    static let shared = NetworkManager()
    private init() {}
    private func request<T: Decodable>(_ endpoint: Endpoint, completion: @escaping (Result<T, Error>) -> Void ) {
        let task = URLSession.shared.dataTask(with: endpoint.request()) { data, response, error in
            if let error = error {
                completion(.failure(error))
                return
            }
            guard let response = response as? HTTPURLResponse, response.statusCode >= 200, response.statusCode <= 299 else {
                completion(.failure("Error in response" as! Error))
                return
            }
            guard let data = data else {
                completion(.failure(NSError(domain: "Error in data", code: 0)))
                return
            }
            do {
                let decodedData = try JSONDecoder().decode(T.self, from: data)
                completion(.success(decodedData))
            } catch let error {
                completion(.failure("Error in JSONDecoder \(error)" as! Error))
            }
        }
        task.resume()
    }
    
    func getProducts(completion: @escaping (Result<[ShopSwiftElement], Error>) -> Void ) {
        let endpoint = Endpoint.getProducts
        request(endpoint, completion: completion)
    }
    func getCategoryProduct(category: String, completion: @escaping (Result<[ShopSwiftElement], Error>) -> Void ) {
        let endpoint = Endpoint.getCategoryProduct(category: category)
        request(endpoint, completion: completion)
    }
}
