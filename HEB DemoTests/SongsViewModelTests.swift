//
//  SongsViewModelTests.swift
//  HEB DemoTests
//
//  Created by Charles Imperato on 10/16/20.
//

import XCTest

import RxSwift
import RxBlocking
import RxCocoa

@testable import HEB_Demo

class SongsViewModelTests: XCTestCase {
    var container = MockDependencyContainer()
    var bag = DisposeBag()
    
    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        container = MockDependencyContainer()
        bag = DisposeBag()
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testSongs_success() {
        let outputs = songListViewModel(dependencies: container, load: .just(()))
        
        guard let songs = try? outputs
            .songs
            .take(1)
            .toBlocking(timeout: 2)
            .first()
        else {
            XCTFail("The event was never emitted.")
            return
        }
        
        XCTAssertEqual(songs.first?.title, "Test Song")
        XCTAssertEqual(songs.first?.artist, "Test Artist")
    }
    
    func testSongs_error() {
        container.errorType = .songs
        let outputs = songListViewModel(dependencies: container, load: .just(()))
        
        guard let error = try? outputs
            .error
            .take(1)
            .toBlocking(timeout: 2)
            .first()
        else {
            XCTFail("The event was never emitted.")
            return
        }
        
        XCTAssertEqual((error as NSError).domain, "test")
        XCTAssertEqual((error as NSError).code, 0)
    }
}
