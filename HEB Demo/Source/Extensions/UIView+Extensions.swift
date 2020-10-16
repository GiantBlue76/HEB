//
//  UIView+Extensions.swift
//  HEB Demo
//
//  Created by Charles Imperato on 10/15/20.
//

import UIKit

extension UIView {
    
    ///
    /// - Creates a more declarative way of adding subviews with the option of executing a closure
    /// - after the view is added.
    /// - Returns the newly added view.
    @discardableResult func add<T: UIView>(view: T, then: (T) -> Void) -> T {
        // Add the view as a subview
        addSubview(view)
        
        // Execute the closure code
        then(view)
        
        // Return the added view
        return view
    }
    
    ///
    /// - Commonly used function to cover an existing view with a subview.
    ///
    func cover(with subView: UIView) {
        subView.translatesAutoresizingMaskIntoConstraints = false
        
        add(view: subView) {
            NSLayoutConstraint
                .activate([
                    $0.topAnchor.constraint(equalTo: topAnchor),
                    $0.leadingAnchor.constraint(equalTo: leadingAnchor),
                    $0.trailingAnchor.constraint(equalTo: trailingAnchor),
                    $0.bottomAnchor.constraint(equalTo: bottomAnchor)
                ])
        }
    }
}
