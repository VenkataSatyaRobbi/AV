//
//  NewsSlideCollectionCell.swift
//  AmericasVision
//
//  Created by Mohan Dola on 14/08/18.
//  Copyright © 2018 zeroGravity. All rights reserved.
//

import Foundation

class NewsSlideCollectionCell: UICollectionViewCell {
    
    var Id:String = ""
    
    var imageView : UIImageView = {
        let view = UIImageView()
        view.translatesAutoresizingMaskIntoConstraints = false
        let image = UIImage(named: "AVDefault")
        view.image = image
        return view
    }()
    
    let headLines: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        label.sizeToFit()
        label.font = UIFont.boldSystemFont(ofSize: 13)
        label.textAlignment = .justified
        label.backgroundColor = UIColor.groupTableViewBackground
        return label
    }()
    
    override init(frame: CGRect) {
        
        super.init(frame: frame)
        backgroundColor = UIColor.white
        self.addSubview(imageView)
        self.addSubview(headLines)
        let width = self.contentView.frame.width - 30
        let height = self.contentView.frame.height
        
        imageView.leftAnchor.constraint(equalTo: leftAnchor, constant:15).isActive = true
        imageView.topAnchor.constraint(equalTo: topAnchor, constant:15).isActive = true
        imageView.heightAnchor.constraint(equalToConstant:110).isActive = true
        imageView.widthAnchor.constraint(equalToConstant:width/2).isActive = true
        
        headLines.leftAnchor.constraint(equalTo: leftAnchor, constant:15).isActive = true
        headLines.topAnchor.constraint(equalTo: topAnchor, constant:100).isActive = true
        headLines.widthAnchor.constraint(equalToConstant: width/2).isActive = true
        headLines.heightAnchor.constraint(equalToConstant: 110).isActive = true
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init code vote cell")
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

}

