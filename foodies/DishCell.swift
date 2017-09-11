//
//  SportCell.swift
//  KindleApp
//
//  Created by Roberto Pirck Valdés on 7/9/17.
//  Copyright © 2017 PEEP TECHNOLOGIES SL. All rights reserved.
//

import UIKit

class SportCell: UICollectionViewCell {
    
    
    let sportImage : UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFill
        return imageView
        
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .white
        layer.cornerRadius = frame.height/2
        clipsToBounds = true
        addSubview(sportImage)
        
        sportImage.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 5).isActive = true
        sportImage.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -5).isActive = true
        sportImage.topAnchor.constraint(equalTo: self.topAnchor, constant: 5).isActive = true
        sportImage.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -5).isActive = true
        
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
