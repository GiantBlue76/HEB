//
//  HomeViewModelTests.swift
//  HEB DemoTests
//
//  Created by Charles Imperato on 10/16/20.
//

import XCTest

import RxSwift
import RxBlocking
import RxCocoa

@testable import HEB_Demo

class HomeViewModelTests: XCTestCase {

    var container = MockDependencyContainer()
    var input = HomeViewModelInput(songsSelected: .just(()))
    var bag = DisposeBag()
    
    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        container = MockDependencyContainer()
        input = HomeViewModelInput(songsSelected: .just(()))
        bag = DisposeBag()
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testSelectSongs_success() {
        let outputs = homeViewModel(dependencies: container, input: input)
        
        guard let route = try? outputs
            .route
            .asObservable()
            .take(1)
            .toBlocking(timeout: 2)
            .first()
        else {
            XCTFail("The event was never emitted.")
            return
        }

        XCTAssertEqual(route, "Routing to songs")
    }
}
