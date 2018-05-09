//
//  PostCollectionViewCell.swift
//  AmericasVision
//
//  Created by Venkata Satya R Robbi on 4/29/18.
//  Copyright © 2018 zeroGravity. All rights reserved.
//

import UIKit

class PostCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var PostCollectionViewImage: UIImageView!
    
    @IBOutlet weak var PostCollectionViewTitle: UILabel!
    @IBOutlet weak var PostCollectionViewText: UITextView!
    
    @IBOutlet weak var PostCollectionViewComments: UILabel!
    @IBOutlet weak var PostCollectionViewDislikes: UILabel!
    @IBOutlet weak var PostCollectionViewLikes: UILabel!
}
