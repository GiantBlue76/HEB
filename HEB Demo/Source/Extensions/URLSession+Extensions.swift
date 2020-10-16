//
//  URLSession+Extensions.swift
//  HEB Demo
//
//  Created by Charles Imperato on 10/15/20.
//

import Foundation
import UIKit

import RxSwift
import RxCocoa

extension URLSession {
    
    ///
    /// - Extension function on URLSession for requesting data using the defined `Endpoint` type.
    /// - Returns an observable emitting an array of the serialized type.
    ///
    func fetch<T: Codable>(endpoint: Endpoint) -> Observable<[T]> {
        rx.data(request: URLRequest(url: endpoint.url))
            .map {                
                // Unwrap the dictionary from the data
                guard let json =
                    try JSONSerialization
                        .jsonObject(
                            with: $0,
                            options: .init()
                        ) as? [String: Any]
                    else { return [] }
                
                // Unwrap the items for the desired elements
                guard let items = json[endpoint.key]
                    else { return [] }
                
                // Convert the items into data to be serialized
                let data = try JSONSerialization.data(withJSONObject: items, options: [])
                return try JSONDecoder().decode([T].self, from: data)
            }
    }
    
    ///
    /// - Fetches an image with a URL
    /// - Returns an observable emitting an optional `UIImage`
    ///
    func fetchImage(url: URL) -> Observable<UIImage?> {
        rx.data(request: URLRequest(url: url))
            .map { UIImage(data: $0) }
    }
}
