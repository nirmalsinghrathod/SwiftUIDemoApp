//
//  User.swift
//  BumbleApp
//
//  Created by Nirmal Singh Rajput on 05/04/24.
//

import Foundation

struct UserArarry: Codable {
    let users: [SpotifyUser]
    let total, skip, limit: Int
}

struct SpotifyUser: Codable,Identifiable {
    let id: Int
    let firstName, lastName, maidenName: String
    let age: Int
    let email, phone, username, password: String
    let birthDate: String
    let image: String
    let bloodGroup: String
    let height: Int
    let weight: Double
    
    
    static var mockUser: SpotifyUser = .init(
        id: 444,
        firstName: "Nirmal",
        lastName: "Rathod",
        maidenName: "Singh",
        age: 27,
        email: "rathod.nirmal401@gmail.com",
        phone: "+91-9300078895",
        username: "nirmal",
        password: "",
        birthDate: "29-03-1997",
        image: Constant.randomImage,
        bloodGroup: "AB+",
        height: 6,
        weight: 62.00
    )
}

struct User: Codable,Identifiable {
    let id: Int
    let firstName, lastName, maidenName: String
    let age: Int
    let email, phone, username, password: String
    let birthDate: String
    let image: String
    let work: String
    let education: String
    let bloodGroup: String
    let aboutMe: String
    let height: Int
    let weight: Double
    
    var images: [String] {
        [
            Constant.randomImage,
            Constant.randomImage1,
            Constant.randomImage2,
        ]
    }
    var basics: [UserInterest] {
        [
        UserInterest(iconName: "ruler", emoji: nil, name: "\(height)"),
        UserInterest(iconName: "graduationcap", emoji: nil, name: education),
        UserInterest(iconName: "wineglass", emoji: nil, name: "Socaially"),
        UserInterest(iconName: "moon.stars.fill", emoji: nil, name: "Virgo")
        ]
    }

    var interests: [UserInterest] {
        [
        UserInterest(iconName: nil, emoji: "👟", name: "Running"),
        UserInterest(iconName: nil, emoji: "🤸‍♀️", name: "Gym"),
        UserInterest(iconName: nil, emoji: "🎧", name: "Music"),
        UserInterest(iconName: nil, emoji: "🥘", name: "Cooking")
        ]
    }
    static var mockUser: User = .init(
        id: 444,
        firstName: "Nirmal",
        lastName: "Rathod",
        maidenName: "Singh",
        age: 27,
        email: "rathod.nirmal401@gmail.com",
        phone: "+91-9300078895",
        username: "nirmal",
        password: "",
        birthDate: "29-03-1997",
        image: Constant.randomImage,
        work: "Work at some place",
        education: "Graduate Degree",
        bloodGroup: "AB+", 
        aboutMe: "This is a sentence about me that will look good on my profile!",
        height: 6,
        weight: 62.00
    )
}
