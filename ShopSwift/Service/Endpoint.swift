//
//  Endpoint.swift
//  ShopSwift
//
//  Created by Şükrü Şimşek on 14.03.2024.
//

import Foundation

enum Endpoint {
    case getProducts
    case getCategoryProduct(category: String)
}

enum HTTPMethod: String {
    case get = "GET"
    case post = "POST"
    case patch = "PATCH"
    case delete = "DELETE"
}

protocol EndpointProtocol {
    var baseURL: String { get }
    var path: String { get }
    var method: HTTPMethod { get }
    var parameters: [String: Any]? { get }
    func request() -> URLRequest
}
extension Endpoint: EndpointProtocol {
    var baseURL: String {
        return "https://fakestoreapi.com"
    }
    //https://sukrusimsek.me/ShopSwift/getProducts.php
    var path: String {
        switch self {
        case .getProducts:
            return "/products"
        case .getCategoryProduct(let category):
            return "/products/category/\(category)" //All Categories: electronics , jewelery , men's clothing, women's clothing
            
        }
    }
    
    
    var method: HTTPMethod {
        switch self {
        case .getProducts: return .get
        case .getCategoryProduct: return .get
        }
    }
    
    
    var parameters: [String : Any]? {
        return nil
    }
    
    func request() -> URLRequest {
        guard var components = URLComponents(string: baseURL) else { fatalError("Fatal error in request") }
        components.path = path
        var request = URLRequest(url: components.url!)
        request.httpMethod = method.rawValue
        return request
    }
    
    
}
