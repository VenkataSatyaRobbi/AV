//
//  ProfileMenuTableViewCell.swift
//  AmericasVision
//
//  Created by Venkata Satya R Robbi on 4/8/18.
//  Copyright © 2018 zeroGravity. All rights reserved.
//

import UIKit

class ProfileMenuTableViewCell: UITableViewCell {

    @IBOutlet weak var ProfileMenuImage: UIImageView!
    @IBOutlet weak var ProfileMenuOptionName: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
