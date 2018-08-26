//
//  MusicTableViewCell.swift
//  AmericasVision
//
//  Created by Venkata Satya R Robbi on 5/5/18.
//  Copyright © 2018 zeroGravity. All rights reserved.
//

import Foundation

class MusicViewCell: UICollectionViewCell{
    
    var Id:String = ""
    
    //var leftPosition:CGFloat = 65
   // var imageSize:CGFloat = 60
    
    
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
        label.font = UIFont.boldSystemFont(ofSize: 14)
        label.textAlignment = .justified
        label.textColor = .white
        label.lineBreakMode = .byWordWrapping
        return label
    }()
    
    let MusicTableTilte: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
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
    
    override init(frame: CGRect) {
        
        super.init(frame: frame)
        
        self.contentView.layer.borderColor = UIColor.groupTableViewBackground.cgColor
        self.contentView.layer.borderWidth = 0.0
        self.contentView.layer.cornerRadius = 5.0
        self.contentView.layer.masksToBounds = false
        self.contentView.backgroundColor = UIColor(red: 15/255, green: 27/255, blue: 41/255, alpha: 1)
        let width1 = self.contentView.layer.frame.width - 30
        self.addSubview(MusicTableImage)
        self.addSubview(MusicTableHeadlines)
        self.addSubview(MusicTableTilte)
        self.addSubview(menuButton)
    }
 
    func setAllignments(imageSize:CGFloat,headLinesLeft:CGFloat,headLinesTop:CGFloat,headLinesWidth:CGFloat,
                        tileTop:CGFloat,titleLeft:CGFloat,menuTop:CGFloat,menuLeft:CGFloat){
        MusicTableImage.topAnchor.constraint(equalTo: topAnchor, constant:5).isActive = true
        MusicTableImage.heightAnchor.constraint(equalToConstant:imageSize).isActive = true
        MusicTableImage.widthAnchor.constraint(equalToConstant:imageSize).isActive = true
        
        MusicTableHeadlines.leftAnchor.constraint(equalTo: leftAnchor, constant:headLinesLeft).isActive = true
        MusicTableHeadlines.topAnchor.constraint(equalTo: topAnchor, constant:headLinesTop).isActive = true
        MusicTableHeadlines.widthAnchor.constraint(equalToConstant: headLinesWidth-20).isActive = true
        
        MusicTableTilte.leftAnchor.constraint(equalTo: leftAnchor, constant:titleLeft).isActive = true
        MusicTableTilte.topAnchor.constraint(equalTo: topAnchor, constant:tileTop).isActive = true
        MusicTableTilte.widthAnchor.constraint(equalToConstant: headLinesWidth-20).isActive = true
        
        menuButton.leftAnchor.constraint(equalTo: leftAnchor, constant:menuLeft).isActive = true
        menuButton.topAnchor.constraint(equalTo: topAnchor, constant:menuTop).isActive = true
        menuButton.widthAnchor.constraint(equalToConstant: 20).isActive = true
    }
    
}
