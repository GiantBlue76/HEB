//
//  BioTableViewCell.swift
//  HEB Demo
//
//  Created by Charles Imperato on 10/15/20.
//

import UIKit

class BioTableViewCell: UITableViewCell, Reusable {

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    /// - Bio collection view
    var collection: UICollectionView? {
        didSet {
            contentView
                .subviews
                .forEach { $0.removeFromSuperview() }
            
            guard let collection = collection
                else { return }
            
            contentView.cover(with: collection)
        }
    }
}
