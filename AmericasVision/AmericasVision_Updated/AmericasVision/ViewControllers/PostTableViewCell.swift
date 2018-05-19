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
  
    var postID: String!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        PostTableViewImage.layer.cornerRadius = 5.0
        PostTableViewImage.clipsToBounds = true
        PostTableViewHeadlines.layer.cornerRadius = 5.0
        PostTableViewHeadlines.clipsToBounds = true
        //PostTableViewbg.layer.cornerRadius = 10.0
       // PostTableViewbg.clipsToBounds = true
       // PostTablebutton.layer.cornerRadius = 5.0
       // PostTablebutton.clipsToBounds = true
    }
}
