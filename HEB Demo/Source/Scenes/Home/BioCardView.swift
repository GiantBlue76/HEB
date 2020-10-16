//
//  BioCardView.swift
//  HEB Demo
//
//  Created by Charles Imperato on 10/15/20.
//

import UIKit

class BioCardView: UIView {
    
    // MARK: - Subviews
    
    private lazy var imageView: UIImageView = {
        let view = UIImageView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.contentMode = .scaleToFill
        view.layer.cornerRadius = 5
        view.layer.masksToBounds = true
        
        return view
    }()
    
    private lazy var nameLabel: UILabel = {
        let label = UILabel(frame: .zero)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        label.lineBreakMode = .byWordWrapping
        label.textColor = .darkGray
        label.textAlignment = .center
        label.font = UIFont.boldSystemFont(ofSize: 12)
        
        return label
    }()
    
    private lazy var instrumentLabel: UILabel = {
        let label = UILabel(frame: .zero)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        label.lineBreakMode = .byWordWrapping
        label.textColor = .darkGray
        label.textAlignment = .center
        label.font = UIFont.systemFont(ofSize: 12)

        return label
    }()
    
    private lazy var bioLabel: UILabel = {
        let label = UILabel(frame: .zero)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        label.lineBreakMode = .byWordWrapping
        label.textColor = .darkGray
        label.textAlignment = .center
        label.font = UIFont.systemFont(ofSize: 12)

        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)

        // View config
        backgroundColor = .white
        
        // Install subviews
        install()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - API
    
    // - NOTE: A UI domain model object could also be used here and reduce this
    // - to a single property.  That may also reduce flexibility.
    
    var image: UIImage? {
        didSet {
            imageView.image = image
        }
    }
    
    var name: String? {
        didSet {
            nameLabel.text = name
        }
    }
    
    var instrument: String? {
        didSet {
            instrumentLabel.text = instrument
        }
    }
    
    var bio: String? {
        didSet {
            bioLabel.text = bio
        }
    }
}

// MARK: - Private

private extension BioCardView {
    
    func install() {
        
        add(view: imageView) {
            NSLayoutConstraint
                .activate([
                    $0.topAnchor.constraint(equalTo: topAnchor),
                    $0.leadingAnchor.constraint(equalTo: leadingAnchor),
                    $0.trailingAnchor.constraint(equalTo: trailingAnchor),
                    $0.heightAnchor.constraint(equalToConstant: 80)
                ])
        }
        
        add(view: nameLabel) {
            NSLayoutConstraint
                .activate([
                    $0.topAnchor.constraint(greaterThanOrEqualTo: imageView.bottomAnchor, constant: 8),
                    $0.leadingAnchor.constraint(equalTo: leadingAnchor),
                    $0.trailingAnchor.constraint(equalTo: trailingAnchor)
                ])
        }
        
        add(view: instrumentLabel) {
            NSLayoutConstraint
                .activate([
                    $0.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 4),
                    $0.leadingAnchor.constraint(equalTo: leadingAnchor),
                    $0.trailingAnchor.constraint(equalTo: trailingAnchor),
                    $0.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -4)
                ])
        }
    }
}
