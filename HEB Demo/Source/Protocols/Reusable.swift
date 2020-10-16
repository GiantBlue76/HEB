//
//  Reusable.swift
//  HEB Demo
//
//  Created by Charles Imperato on 10/15/20.
//

import UIKit

protocol Reusable {

    /// - Default reuse identifier for the reusable item
    static var defaultIdentifier: String { get }
}

/// - Default implementation for a UIView
extension Reusable where Self: UIView {
    
    static var defaultIdentifier: String {
        String(describing: self)
    }
}

/// - Extension for UITableViewCells and UICollectionViewCells

extension UITableView {
    
    /// - Registers a table view cell using generics
    func register<T: UITableViewCell>(ofType: T.Type) where T: Reusable {
        register(T.self, forCellReuseIdentifier: T.defaultIdentifier)
    }
    
    /// - Dequeues a table view cell by registering it first.
    /// - This is less error prone not requiring the separate operation of registering
    func dequeueCell<T: UITableViewCell>(path: IndexPath) -> T where T: Reusable {
        register(ofType: T.self)
        
        guard let cell = dequeueReusableCell(withIdentifier: T.defaultIdentifier, for: path) as? T
            else {
                fatalError("The cell could not be instantiated for type: \(T.self)")
            }
        
        return cell
    }
}

extension UICollectionView {
    
    func register<T: UICollectionViewCell>(ofType: T.Type) where T: Reusable {
        register(T.self, forCellWithReuseIdentifier: T.defaultIdentifier)
    }
    
    /// - Register a collection view cell using generics
    func dequeueCell<T: UICollectionViewCell>(path: IndexPath) -> T where T: Reusable {
        register(ofType: T.self)
        
        guard let cell = dequeueReusableCell(withReuseIdentifier: T.defaultIdentifier, for: path) as? T
            else {
                fatalError("The cell could not be instantiated for type: \(T.self)")
            }
        
        return cell
    }
}
