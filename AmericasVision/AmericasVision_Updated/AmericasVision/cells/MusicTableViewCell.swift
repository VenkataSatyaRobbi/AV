//
//  MusicTableViewCell.swift
//  AmericasVision
//
//  Created by Venkata Satya R Robbi on 5/5/18.
//  Copyright © 2018 zeroGravity. All rights reserved.
//

import UIKit

class MusicTableViewCell: UITableViewCell {

    @IBOutlet weak var MusicTableImage: UIImageView!
    @IBOutlet weak var MusicTableHeadlines: UITextView!
    @IBOutlet weak var MusicTablebg: UIView!
    @IBOutlet weak var MusicScrollview: UIScrollView!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
       // MusicTableImage.layer.cornerRadius = 5.0
       // MusicTableImage.clipsToBounds = true
       // MusicTablebg.layer.cornerRadius = 5.0
       // MusicTablebg.clipsToBounds = true
        
        
//        MusicTablebg.backgroundColor = UIColor.white
//        MusicTablebg.layer.cornerRadius = 5.0
//        MusicTablebg.layer.masksToBounds = false
//        MusicTablebg.layer.shadowColor =
//            UIColor.white.withAlphaComponent(0.2).cgColor
//        MusicTablebg.layer.shadowOffset = CGSize(width: 0, height: 0)
//        MusicTablebg.layer.shadowOpacity =  0.8
//
        
        
      //   self.MusicScrollview.contentSize.height = 1.0
      
    }
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    

}

