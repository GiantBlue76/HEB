//
//  BandMemberViewModelTests.swift
//  HEB DemoTests
//
//  Created by Charles Imperato on 10/16/20.
//

import XCTest

import RxSwift
import RxBlocking
import RxCocoa

@testable import HEB_Demo

class BandMemberViewModelTests: XCTestCase {

    var input = BandMemberInput(load: .just(()))
    var container = MockDependencyContainer()
    var bag = DisposeBag()
    
    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        container = MockDependencyContainer()
        input = BandMemberInput(load: .just(()))
        bag = DisposeBag()
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testMembers_success() {
        let outputs = bandMemberViewModel(dependencies: container, input: input)

        guard let members = try? outputs
            .members
            .take(1)
            .toBlocking(timeout: 2)
            .first()
        else {
            XCTFail("The event was never emitted.")
            return
        }
        
        XCTAssertEqual(members.first?.name, "Chuck")
        XCTAssertEqual(members.first?.instrument, "guitar")
    }
    
    func testMembers_error() {
        container.errorType = .members
        let outputs = bandMemberViewModel(dependencies: container, input: input)

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
