//
//  PlaySportsHeader.swift
//  PlaySportsTest
//
//  Created by R K Marri on 14/02/2019.
//  Copyright © 2019 R K Marri. All rights reserved.
//

import UIKit

class PlaySportsHeader: UICollectionViewCell {
    
    let logoImageView: UIImageView = {
        let iv = UIImageView()
        iv.image = #imageLiteral(resourceName: "play-eb")
        iv.contentMode = .scaleAspectFill
        return iv
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setUpUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    fileprivate func setUpUI() {
        
        addSubview(logoImageView)
        logoImageView.anchor(top: self.topAnchor, leading: self.leadingAnchor, bottom: self.bottomAnchor, trailing: self.trailingAnchor)
    }
    
}
