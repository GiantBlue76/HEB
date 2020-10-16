//
//  LoadingViewController.swift
//  HEB Demo
//
//  Created by Charles Imperato on 10/15/20.
//

import UIKit

class LoadingViewController: UIViewController {

    // MARK: - Subviews
    
    private lazy var activityIndicator: UIActivityIndicatorView = {
        let view = UIActivityIndicatorView(style: .large)
        view.translatesAutoresizingMaskIntoConstraints = false
        view.color = .white
    
        return view
    }()
    
    private lazy var messageLabel: UILabel = {
        let label = UILabel(frame: .zero)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .white
        label.font = UIFont.boldSystemFont(ofSize: 14)
        label.numberOfLines = 0
        label.textAlignment = .center
        label.lineBreakMode = .byWordWrapping
        
        return label
    }()
    
    private lazy var overlayView: UIView = {
        let view = UIView(frame: .zero)
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = UIColor.black.withAlphaComponent(0.7)
        
        return view
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        view.backgroundColor = .clear
        
        // Install subviews
        install()
        
        // Start animating
        activityIndicator.startAnimating()
    }
    
    // MARK: - API
    
    var loadingMessage: String? {
        didSet {
            messageLabel.text = loadingMessage
        }
    }
}

// MARK: - Private

private extension LoadingViewController {
    
    func install() {
        view.cover(with: overlayView)
        
        // Layout the activity indicator
        view.add(view: activityIndicator) {
            NSLayoutConstraint
                .activate([
                    $0.widthAnchor.constraint(equalToConstant: 48),
                    $0.heightAnchor.constraint(equalToConstant: 48),
                    $0.centerYAnchor.constraint(equalTo: view.centerYAnchor),
                    $0.centerXAnchor.constraint(equalTo: view.centerXAnchor)
                ])
        }
        
        view.add(view: messageLabel) {
            NSLayoutConstraint
                .activate([
                    $0.topAnchor.constraint(equalTo: activityIndicator.bottomAnchor, constant: 8),
                    $0.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.4),
                    $0.centerXAnchor.constraint(equalTo: view.centerXAnchor)
                ])
        }
    }
}
