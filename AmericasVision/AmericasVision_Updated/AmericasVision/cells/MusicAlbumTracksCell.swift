//
//  MusicAlbumTracksCell.swift
//  AmericasVision
//
//  Created by Mohan Dola on 28/05/18.
//  Copyright © 2018 zeroGravity. All rights reserved.
//

import UIKit

class MusicAlbumTracksCell: UICollectionViewCell {
    
    var imageView : UIImageView = {
        let view = UIImageView()
        view.translatesAutoresizingMaskIntoConstraints = false
        let image = UIImage(named: "Unknown")
        view.image = image
        return view
    }()
    
    let title: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.boldSystemFont(ofSize: 12)
        label.textAlignment = .justified
        label.textColor = .black
        label.lineBreakMode = .byWordWrapping
        return label
    }()
    
    let menuButton: UIButton = {
        let menuButton = UIButton()
        menuButton.translatesAutoresizingMaskIntoConstraints = false
        menuButton.setTitle(":", for: .normal)
        return menuButton
    }()
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override init(frame: CGRect) {
        
        super.init(frame: frame)
        
        self.contentView.layer.borderColor = UIColor.groupTableViewBackground.cgColor
        self.contentView.layer.borderWidth = 0.0
        self.contentView.layer.masksToBounds = false
        self.contentView.backgroundColor = .white
        
        self.addSubview(imageView)
        self.addSubview(title)
        self.addSubview(menuButton)
        
        self.layer.shadowColor = UIColor.black.cgColor
        self.layer.shadowOffset = CGSize(width: 0, height: 1.0)
        self.layer.shadowRadius = 1.0
        self.layer.shadowOpacity = 0.5
        self.layer.masksToBounds = false
        self.layer.shadowPath = UIBezierPath(roundedRect: self.bounds, cornerRadius: self.layer.cornerRadius).cgPath
    }
    
    func setAllignments(imageSize:CGFloat,tileTop:CGFloat,menuTop:CGFloat,menuLeft:CGFloat){
        imageView.topAnchor.constraint(equalTo: topAnchor, constant:0).isActive = true
        imageView.heightAnchor.constraint(equalToConstant:imageSize).isActive = true
        imageView.widthAnchor.constraint(equalToConstant:imageSize).isActive = true
        
        title.leftAnchor.constraint(equalTo: leftAnchor, constant:imageSize).isActive = true
        title.topAnchor.constraint(equalTo: topAnchor, constant:tileTop).isActive = true
        title.widthAnchor.constraint(equalToConstant: self.contentView.layer.frame.width-imageSize).isActive = true
        
        menuButton.leftAnchor.constraint(equalTo: leftAnchor, constant:menuLeft).isActive = true
        menuButton.topAnchor.constraint(equalTo: topAnchor, constant:menuTop).isActive = true
        menuButton.widthAnchor.constraint(equalToConstant: 20).isActive = true
    }
    
    
}
