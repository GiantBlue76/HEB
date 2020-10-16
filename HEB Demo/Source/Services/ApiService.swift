//
//  ApiService.swift
//  HEB Demo
//
//  Created by Charles Imperato on 10/15/20.
//

import Foundation

import RxSwift

// MARK: - Endpoint

/// - Describes an endpoint for the application
enum Endpoint {
    case songs
    case shows
    case members
    case venues
}

extension Endpoint {
    
    /// Mappng key for JSON
    var key: String {
        switch self {
        case .songs:
            return "songs"
        case .shows:
            return "events"
        case .members:
            return "members"
        case .venues:
            return "venues"
        }
    }
}

extension Endpoint {
    
    /// - Creates a valid URL for the endpoint
    var url: URL {
        var base = "https://fusionatx.com"
        
        switch self {
        case .songs:
            base += "/songs.json"
        case .members:
            base += "/members.json"
        case .shows, .venues:
            base += "/events.json"
        }
        
        /// Debug mode failure
        guard let url = URL(string: base) else {
            preconditionFailure("Invalid URL specified")
        }
        
        return url
    }
}

// MARK: - API service

/// - API Client used to make service calls
struct ApiService{
        
    /// - Fetches a model type from the API
    var songs: () -> Observable<[Song]>
    
    /// - Fetches band members
    var members: () -> Observable<[BandMember]>
    
    /// - Fetches the events
    var shows: () -> Observable<[Event]>
    
    /// - Fetches the venues
    var venues: () -> Observable<[Venue]>
}

/// - Live version of the fetch function
extension ApiService {
    
    /// LIve implementation for the data retrieval
    static let live = Self.init(
        songs: {
            URLSession
                .shared
                .fetch(endpoint: .songs)
        },
        members: {
            URLSession
                .shared
                .fetch(endpoint: .members)
        },
        shows: {
            URLSession
                .shared
                .fetch(endpoint: .shows)
        },
        venues: {
            URLSession
                .shared
                .fetch(endpoint: .venues)
        }
    )
}

/// - Protocol for objects containing an API service
protocol HasApiService {
    var api: ApiService { get }
}
