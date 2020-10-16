//
//  BioCollectionViewCell.swift
//  HEB Demo
//
//  Created by Charles Imperato on 10/15/20.
//

import UIKit

import RxSwift

class BioCollectionViewCell: UICollectionViewCell, Reusable {
    
    // TODO: Could just be a generic view?  Do we care?
    private lazy var content: BioCardView = {
        let view = BioCardView()
        view.translatesAutoresizingMaskIntoConstraints = false
        
        return view
    }()
    
    var bag = DisposeBag()
    
    override init(frame: CGRect) {
        super.init(frame: .zero)
        
        // configure the view
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func prepareForReuse() {
        content.image = nil
        content.name = nil
        content.instrument = nil
        model = nil
        
        bag = DisposeBag()
    }
    
    // MARK: - API
    
    var model: BandMemberDisplay? {
        didSet {
            content.name = model?.name
            content.instrument = model?.instrument
            
            // These images would normally be cached locally
            // but for time constraints they are just loaded each time the cell
            // is dequeued.  A separate view model could even be used for the cell to trigger loading the
            // image from the cache when the url is set and also asynchronously updating the image
            // over the network.  The image cache would be observable and the cell would simply
            // observe changes to the cache.  The cache would handle persistence.
            if let url = model?.image {
                URLSession
                    .shared
                    .fetchImage(url: url)
                    .observeOn(MainScheduler.instance)
                    .subscribe(onNext: { [content] in
                        content.image = $0
                    })
                    .disposed(by: bag)
            }
        }
    }
}

// MARK: - Private

private extension BioCollectionViewCell {
    
    func configure() {
        contentView.layer.borderWidth = 1
        contentView.layer.borderColor = UIColor.darkGray.cgColor
        contentView.layer.cornerRadius = 5
        contentView.layer.masksToBounds = true        
        contentView.cover(with: content)
    }
}
