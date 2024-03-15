//
//  Model.swift
//  ShopSwift
//
//  Created by Şükrü Şimşek on 14.03.2024.
//


import Foundation

// MARK: - ShopSwiftElement
struct ShopSwiftElement: Codable {
    let id: Int?
    let title: String?
    let price: Double?
    let description: String?
    let category: Category?
    let image: String?
    let rating: Rating?
}

enum Category: String, Codable {
    case electronics = "electronics"
    case jewelery = "jewelery"
    case menSClothing = "men's clothing"
    case womenSClothing = "women's clothing"
}

// MARK: - Rating
struct Rating: Codable {
    let rate: Double?
    let count: Int?
}

