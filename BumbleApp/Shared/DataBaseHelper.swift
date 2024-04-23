//
//  DataBaseHelper.swift
//  BumbleApp
//
//  Created by Nirmal Singh Rajput on 05/04/24.
//

import Foundation

struct DataBaseHelper{
    
    func getProducts() async throws -> [Product]{
        guard let url = URL(string: "https://dummyjson.com/products") else {
            throw URLError.init(.badURL)
        }
        
        let (data, response) = try await URLSession.shared.data(from: url)
        let product = try JSONDecoder().decode(ProductArray.self, from: data)
        
        return product.products
    }
    
    
    func getUsers() async throws -> [SpotifyUser]{
        guard let url = URL(string: "https://dummyjson.com/users") else {
            throw URLError.init(.badURL)
        }
        
        let (data, response) = try await URLSession.shared.data(from: url)
        let product = try JSONDecoder().decode(UserArarry.self, from: data)
        
        return product.users
    }
}
