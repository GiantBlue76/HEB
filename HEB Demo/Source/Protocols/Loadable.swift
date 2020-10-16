//
//  Loadable.swift
//  HEB Demo
//
//  Created by Charles Imperato on 10/15/20.
//

import UIKit

/// - Conforming to this protocol will allow the object to display a loading view
protocol Loadable {}

/// - Displaying a loading view from a view controller
extension Loadable where Self: UIViewController {
    
    func showLoading(message: String? = nil, animated: Bool = true, _ completion: (() -> Void)? = nil) {
        let loader = LoadingViewController()
        loader.modalPresentationStyle = .overFullScreen
        loader.modalTransitionStyle = .crossDissolve
        loader.loadingMessage = message
        
        present(loader, animated: true, completion: completion)
    }
    
    func hideLoading(animated: Bool = true, _ completion: (() -> Void)? = nil) {
        guard let presented = presentedViewController as? LoadingViewController
            else { return }
        
        presented.dismiss(animated: animated, completion: completion)
    }
}
