//
//  SportsVideoCell.swift
//  PlaySportsTest
//
//  Created by R K Marri on 14/02/2019.
//  Copyright © 2019 R K Marri. All rights reserved.
//

import UIKit
import SDWebImage

class SportsVideoCell: UICollectionViewCell {
    
    var videoItem: RawItem! {
        didSet {
            titleLabel.text = videoItem.snippet.title
            let thumbnailUrl = URL(string: videoItem.snippet.thumbnails.medium.url)
            thumbnailView.sd_setImage(with: thumbnailUrl, completed: nil)
        }
    }
    
    fileprivate let thumbnailHeight:CGFloat = 200.0
    fileprivate let padding:CGFloat = 16.0
    
    fileprivate let thumbnailView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = #imageLiteral(resourceName: "thumbnail")
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()
    
    fileprivate let titleLabel: UILabel = {
        let label = UILabel()
        label.text = "This is a very long Title, to check how it displays in multiple line, lets checkout."
        label.font = UIFont.boldSystemFont(ofSize: 18)
        label.numberOfLines = 0
        label.textColor = .gray
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .white
        self.layer.cornerRadius = 6
        self.clipsToBounds = true
        setUpUI()
    }
    
    fileprivate func setUpUI() {
        thumbnailView.heightAnchor.constraint(equalToConstant: thumbnailHeight).isActive = true
        let stackView = UIStackView(arrangedSubviews: [thumbnailView, titleLabel])
        stackView.axis = .vertical
        addSubview(stackView)
        stackView.anchor(top: self.topAnchor, leading: self.leadingAnchor, bottom: self.bottomAnchor, trailing: self.trailingAnchor)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    
}
