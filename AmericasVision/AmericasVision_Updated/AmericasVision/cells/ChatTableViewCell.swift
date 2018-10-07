//
//  ChatTableViewCell.swift
//  AmericasVision
//
//  Created by Mohan Dola on 26/05/18.
//  Copyright © 2018 zeroGravity. All rights reserved.
//

import UIKit

class ChatTableViewCell: UITableViewCell {

    @IBOutlet weak var ChatTableViewCellImage: UIImageView!
    @IBOutlet weak var ChatTableViewCellUsername: UILabel!
    @IBOutlet weak var ChatTableViewCellCaption: UILabel!
    @IBOutlet weak var chatTableview: UITableView!
    @IBOutlet weak var ChatTableViewCellDate: UILabel!
    @IBOutlet weak var ChatTableViewCellComment: UILabel!
    
    var postID: String!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        ChatTableViewCellImage.layer.cornerRadius = 20
        ChatTableViewCellImage.clipsToBounds = true
    }
    

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    func resgistredchatcell<DataSource:UITableViewDataSource>(datasource:DataSource){
        self.chatTableview.dataSource = datasource
    }
}
