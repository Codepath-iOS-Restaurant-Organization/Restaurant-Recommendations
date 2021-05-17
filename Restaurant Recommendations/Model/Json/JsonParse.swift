//
//  JsonParse.swift
//  Restaurant Recommendation
//
//  Created by Richard Basdeo on 4/3/21.
//

import Foundation
struct yelpReturnedBusinesses: Codable {
    
    let businesses: [businesses]
    
}

struct businesses: Codable {
    
    let rating: Float
    let review_count: Int
    let name: String
    let image_url: String
    let categories: [categories]
    let phone: String
    let coordinates : coordinates
    let id: String
    let location: location
    let price: String?
}

struct location: Codable {
    let address1: String
    let city: String
    let state: String
    let zip_code: String
    let country: String
}

struct categories: Codable {
    let alias: String
    let title: String
}

struct coordinates: Codable {
    let latitude: Float
    let longitude: Float
}
