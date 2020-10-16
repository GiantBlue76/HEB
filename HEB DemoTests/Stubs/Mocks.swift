//
//  Mocks.swift
//  HEB DemoTests
//
//  Created by Charles Imperato on 10/16/20.
//

import Foundation

import RxSwift
import RxCocoa

@testable import HEB_Demo

// - Create the mocked versions of the ApiService.  No need for protocols and all of the
// - boiler plate.  Reference - www.pointfree.co.

extension ApiService {

    static let mockSuccess = Self.init(
        songs: {
            .just([Song(title: "Test Song", artist: "Test Artist", genreId: "")])
        },
        members: {
            .just([BandMember(name: "Chuck", image: "", thumb: "", instrument: "guitar", bio: "Awesome")])
        },
        shows: { .just([]) },
        venues: { .just([]) }
    )
    
    static let mockSongsError = Self.init(
        songs: { .error(NSError(domain: "test", code: 0, userInfo: nil)) },
        members: { .just([]) },
        shows: { .just([]) },
        venues: { .just([]) }
    )
    
    static let mockMembersError = Self.init(
        songs: { .just([]) },
        members: { .error(NSError(domain: "test", code: 0, userInfo: nil)) },
        shows: { .just([]) },
        venues: { .just([]) }
    )
}

extension Logger {
    static let mock = Self { message, level in
        .just(())
    }
}

enum ErrorType: Int {
    case songs
    case members
    case none
}

// - Mock dependency graph
class MockDependencyContainer: HasApiService & HasLogger {
    var errorType: ErrorType = .none

    //
    // - Mock services
    //
    var api: ApiService {
        switch errorType {
        case .none:
            return .mockSuccess
        case .members:
            return .mockMembersError
        case .songs:
            return .mockSongsError
        }
    }
    
    //
    // - Logger
    //
    var logger: Logger { .mock }
}
