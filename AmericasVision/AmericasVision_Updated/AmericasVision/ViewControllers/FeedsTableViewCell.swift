//
//  FeedsTableViewCell.swift
//  AmericasVision
//
//  Created by Mohan Dola on 20/05/18.
//  Copyright © 2018 zeroGravity. All rights reserved.
//

import UIKit

class FeedsTableViewCell: UITableViewCell {
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    func registerCollectoinView<DataSource:UICollectionViewDataSource>(datasource:DataSource){
        self.collectionView.dataSource = datasource
    }
  

}
