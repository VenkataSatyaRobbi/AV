//
//  PostTableViewCell.swift
//  AmericasVision
//
//  Created by Venkata Satya R Robbi on 5/13/18.
//  Copyright © 2018 zeroGravity. All rights reserved.
//

import UIKit

class PostTableViewCell: UITableViewCell {
    
    @IBOutlet weak var PostTableViewImage: UIImageView!
    @IBOutlet weak var PostTableViewHeadlines: UITextView!
    @IBOutlet weak var PostTableViewbg: UIView!
    @IBOutlet weak var PostTablebutton: UIButton!
    @IBOutlet weak var collectionView: UICollectionView!
   @IBOutlet weak var PostCollectionViewCaption: UITextView!
    var postID: String!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        PostTableViewImage.layer.cornerRadius = 5.0
        PostTableViewImage.clipsToBounds = true
        PostTableViewHeadlines.layer.cornerRadius = 5.0
        PostTableViewHeadlines.clipsToBounds = true
     // PostCollectionViewCaption.layer.cornerRadius = 5.0
     // PostCollectionViewCaption.clipsToBounds = true
     //    PostCollectionViewCaption.isScrollEnabled = false
       // PostTablebutton.layer.cornerRadius = 5.0
       // PostTablebutton.clipsToBounds = true
        
        
        PostTableViewbg.backgroundColor = UIColor.white
        PostTableViewbg.layer.cornerRadius = 5.0
        PostTableViewbg.layer.masksToBounds = false
        PostTableViewbg.layer.shadowColor =
            UIColor.white.withAlphaComponent(0.2).cgColor
        PostTableViewbg.layer.shadowOffset = CGSize(width: 0, height: 0)
        PostTableViewbg.layer.shadowOpacity =  0.8
    }
    
   func registerCollectoinView<DataSource:UICollectionViewDataSource>(datasource:DataSource){
        self.collectionView.dataSource = datasource
    }
    
   
}
