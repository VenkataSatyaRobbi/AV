//
//  MusicAlbumTableViewCell.swift
//  AmericasVision
//
//  Created by Mohan Dola on 28/05/18.
//  Copyright © 2018 zeroGravity. All rights reserved.
//

import UIKit

class MusicAlbumTableViewCell: UITableViewCell {
    @IBOutlet weak var albumViewImage: UIImageView!
    @IBOutlet weak var albumViewHeadlines: UITextView!
    @IBOutlet weak var albumViewbg: UIView!
    @IBOutlet weak var albumbutton: UIButton!
    @IBOutlet weak var collectionView: UICollectionView!
    
    var postID: String!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        albumViewImage.layer.cornerRadius = 5.0
        albumViewImage.clipsToBounds = true
        albumViewImage.layer.cornerRadius = 5.0
        albumViewImage.clipsToBounds = true
       
        
    }
    
    func registerCollectoinView<DataSource:UICollectionViewDataSource>(datasource:DataSource){
        self.collectionView.dataSource = datasource
    }
    
}
