//
//  MusicTableViewCell.swift
//  HEB Demo
//
//  Created by Charles Imperato on 10/16/20.
//

import UIKit

class MusicTableViewCell: UITableViewCell, Reusable {

    private lazy var songsImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.layer.cornerRadius = 32 // Since this view is a static size, to round the edges we know the corner radius
        imageView.layer.borderWidth = 1
        imageView.layer.borderColor = UIColor.black.cgColor
        imageView.contentMode = .scaleAspectFill
        imageView.image = .songsFolder
        
        return imageView
    }()
    
    private lazy var songsLabel: UILabel = {
        let label = UILabel(frame: .zero)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Tap Here for the Song List"
        label.font = .boldSystemFont(ofSize: 26)
        label.numberOfLines = 0
        
        return label
    }()
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        // Configure subviews
        install()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: - Private

private extension MusicTableViewCell {
    
    func install() {
        contentView.layer.borderWidth = 1
        contentView.layer.borderColor = UIColor.darkGray.cgColor
        
        contentView.add(view: songsImageView) {
            NSLayoutConstraint
                .activate([
                    $0.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 16),
                    $0.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
                    $0.heightAnchor.constraint(equalToConstant: 64),
                    $0.widthAnchor.constraint(equalToConstant: 64)
                ])
        }
        
        contentView.add(view: songsLabel) {
            NSLayoutConstraint
                .activate([
                    $0.topAnchor.constraint(equalTo: songsImageView.bottomAnchor, constant: 16),
                    $0.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 24),
                    $0.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -24),
                    $0.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -32)
                ])
        }
    }
}
