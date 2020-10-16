//
//  Model.swift
//  HEB Demo
//
//  Created by Charles Imperato on 10/15/20.
//

import Foundation

/// - Tracked genre types
struct Genre: Codable {
    
    let id: String
    let title: String
    
}

/// - Song
struct Song: Codable {
    
    enum CodingKeys: String, CodingKey {
        case genreId = "genre_id"
        case title
        case artist
    }
    
    let title: String
    let artist: String
    let genreId: String

}

/// - Performance venue
struct Venue: Codable {
    
    let id: String
    let name: String
    let poster: String
    let address: String
    let city: String
    let state: String
    
}

/// - Shows
struct Event: Codable {
    
    enum CodingKeys: String, CodingKey {
        case venueId = "venue_id"
        case start
        case end
        case summary
    }
    
    let start: String
    let end: String
    let venueId: String
    let summary: String
}

/// - Band member
struct BandMember: Codable {
    
    let name: String
    let image: String
    let thumb: String
    let instrument: String
    let bio: String
    
}
