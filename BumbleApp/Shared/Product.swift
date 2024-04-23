//
//  Product.swift
//  BumbleApp
//
//  Created by Nirmal Singh Rajput on 05/04/24.
//

import Foundation

struct ProductArray: Codable {
    let products: [Product]
    let total, skip, limit: Int
}

struct Product: Codable,Identifiable {
    let id: Int
    let title, description: String
    let price: Int
    let discountPercentage, rating: Double
    let stock: Int
    let brand, category: String
    let thumbnail: String
    let images: [String]
    
    var firstImage: String{
        images.first ?? Constant.randomImage
    }
    
    
    static var mockProduct: Product = .init(id: 123, title: "Exmaple Product Title", description: "This is some Mock product Description", price: 999, discountPercentage: 15, rating: 4.5, stock: 50, brand: "Apple", category: "Electronic Device", thumbnail: Constant.randomImage, images: [Constant.randomImage,Constant.randomImage,Constant.randomImage])
    
}

struct ProductRow: Identifiable{
    let id = UUID().uuidString
    let title: String
    let products: [Product]
}


struct UserInterest: Identifiable{
    let id = UUID().uuidString
    var iconName: String? = nil
    var emoji: String? = nil
    var name: String
}
