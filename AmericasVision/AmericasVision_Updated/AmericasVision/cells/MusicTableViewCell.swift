//
//  MusicTableViewCell.swift
//  AmericasVision
//
//  Created by Venkata Satya R Robbi on 5/5/18.
//  Copyright © 2018 zeroGravity. All rights reserved.
//

import Foundation

class MusicTableViewCell: UITableViewCell{
    
    var Id:String = ""
    
    var MusicTableImage : UIImageView = {
        let view = UIImageView()
        view.translatesAutoresizingMaskIntoConstraints = false
        let image = UIImage(named: "Unknown")
        view.image = image
        return view
    }()
    
    let MusicTableHeadlines: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        label.sizeToFit()
        label.font = UIFont.boldSystemFont(ofSize: 12)
        label.textAlignment = .justified
        label.textColor = .white
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
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        self.contentView.layer.borderColor = UIColor.groupTableViewBackground.cgColor
        self.contentView.layer.borderWidth = 2.0
        self.contentView.layer.cornerRadius = 5.0
        self.contentView.layer.masksToBounds = false
        self.contentView.backgroundColor = UIColor(red: 15/255, green: 27/255, blue: 41/255, alpha: 1)
        let width = self.contentView.layer.frame.width - 30
        self.addSubview(MusicTableImage)
        self.addSubview(MusicTableHeadlines)
        self.addSubview(menuButton)

        MusicTableImage.topAnchor.constraint(equalTo: topAnchor, constant:5).isActive = true
        MusicTableImage.heightAnchor.constraint(equalToConstant:60).isActive = true
        MusicTableImage.widthAnchor.constraint(equalToConstant:60).isActive = true

        MusicTableHeadlines.leftAnchor.constraint(equalTo: leftAnchor, constant:65).isActive = true
        MusicTableHeadlines.topAnchor.constraint(equalTo: topAnchor, constant:5).isActive = true
        MusicTableHeadlines.widthAnchor.constraint(equalToConstant: width-85).isActive = true

        menuButton.rightAnchor.constraint(equalTo: rightAnchor, constant:-5).isActive = true
        menuButton.topAnchor.constraint(equalTo: topAnchor, constant:5).isActive = true
        menuButton.widthAnchor.constraint(equalToConstant: 20).isActive = true
        
    }
    
}
