//
//  DependencyContainer.swift
//  HEB Demo
//
//  Created by Charles Imperato on 10/15/20.
//

import Foundation

typealias ContainerType = HasApiService & HasLogger

///
/// - Class which conforms to the necessary protocols to provide dependencies
/// - for the application.
///
class DependencyContainer: ContainerType {
    
    /// - Provides the API service implementation
    var api: ApiService { .live }
    
    /// - Provides the logger implementation
    var logger: Logger { .live }
}
