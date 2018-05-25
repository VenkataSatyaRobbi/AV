//
//  SlideCollectionViewCell.swift
//  AmericasVision
//
//  Created by Mohan Dola on 20/05/18.
//  Copyright © 2018 zeroGravity. All rights reserved.
//

import UIKit

class SlideCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var cellImage: UIImageView!
      @IBOutlet weak var headlines: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
       cellImage.layer.cornerRadius = 5.0
       cellImage.clipsToBounds = true
        
        headlines.layer.cornerRadius = 5.0
        headlines.clipsToBounds = true
    }
}
