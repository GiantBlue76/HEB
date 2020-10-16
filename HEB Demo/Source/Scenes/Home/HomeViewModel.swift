//
//  HomeViewModel.swift
//  HEB Demo
//
//  Created by Charles Imperato on 10/16/20.
//

import RxSwift
import RxCocoa

func homeViewModel(dependencies: HasApiService & HasLogger, input: HomeViewModelInput) -> HomeViewModelOutput {
    let route =
        input
            .songsSelected
            .flatMap {
                dependencies
                    .logger
                    .log("Routing invoked", .debug)                
            }
            .map { "Routing to songs" }
            .asDriver(onErrorJustReturn: "Routing to songs")
    
    return HomeViewModelOutput(route: route)
}

/// - Input
struct HomeViewModelInput {
    let songsSelected: Observable<Void>
    
    // TODO: Other selectable elements (inputs) would go here
}

struct HomeViewModelOutput {

    // - If we were using a router or Coordinator this might be an enum which contained enough
    // - meta data to describe to the router how to render the view controller to be
    // - navigated to next.  Using a router/coordinator would keep view controllers decoupled from
    // - each other.  Another way to avoid tight coupling would be to use a ViewControllerFactory which would be
    // - part of the Dependency graph and can be mocked for testing.
    
    // - For now we will send back a driver with a string that won't be used.
    let route: Driver<String>
}
