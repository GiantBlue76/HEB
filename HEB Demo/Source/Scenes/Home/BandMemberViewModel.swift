//
//  BandMemberViewModel.swift
//  HEB Demo
//
//  Created by Charles Imperato on 10/15/20.
//

import Foundation

import RxSwift
import RxCocoa

typealias BandMemberServices = HasApiService

func bandMemberViewModel(dependencies: BandMemberServices, input: BandMemberInput) -> BandMemberOutput {
    let members = input
        .load
        .flatMap {
            dependencies
                .api
                .members()
                .map {
                    $0.map {
                        BandMemberDisplay(
                            name: $0.name,
                            instrument: $0.instrument,
                            bio: $0.bio,
                            image: URL(string: $0.image)
                        )
                    }
                }
                .materialize()
                .filter { $0.isCompleted == false }
        }
        .share(replay: 1)
    
    let success = members.compactMap { $0.element }
    let error = members.compactMap { $0.error }
    
    return BandMemberOutput(members: success, error: error)
}

/// - Inputs
struct BandMemberInput {
    
    let load: Observable<Void>
}

/// - Outputs
struct BandMemberOutput {
    
    let members: Observable<[BandMemberDisplay]>
    let error: Observable<Error>
}

/// - Domain display object for the cell
struct BandMemberDisplay {
    
    let name: String
    let instrument: String
    let bio: String
    let image: URL?
}
