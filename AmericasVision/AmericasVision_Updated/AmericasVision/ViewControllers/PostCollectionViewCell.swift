//
//  PostCollectionViewCell.swift
//  AmericasVision
//
//  Created by Venkata Satya R Robbi on 4/29/18.
//  Copyright © 2018 zeroGravity. All rights reserved.
//

import UIKit
import FirebaseDatabase

class PostCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var PostCollectionViewImage: UIImageView!
    @IBOutlet weak var PostCollectionViewHeadlines: UITextView!
    @IBOutlet weak var PostCollectionViewLikes: UILabel!
    @IBOutlet weak var PostCollectionViewContent: UITextView!
    @IBOutlet weak var PostCollectionViewDislikes: UILabel!
    @IBOutlet weak var PostCollectionViewComments: UILabel!
    
    var postID: String!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        PostCollectionViewImage.layer.cornerRadius = 5.0
        PostCollectionViewImage.clipsToBounds = true
    }
    
    @IBAction func postCollectionViewLikeButtonClicked(_ sender: Any) {
        Database.database().reference().child("posts").child(self.postID).child("likes").runTransactionBlock({
            (currentData: MutableData!) in
            var value = currentData.value as? Int
            //check to see if the likes node exists, if not give value of 0.
            if (value == nil) {
                value = 0
            }
            currentData.value = value! + 1
            //self.PostCollectionViewLikes.text = currentData.value as? String
            return TransactionResult.success(withValue: currentData)
            
        })
    }
    
    @IBAction func postCollectionViewDislikeButtonClicked(_ sender: Any) {
        Database.database().reference().child("posts").child(self.postID).child("dislikes").runTransactionBlock({
            (currentData: MutableData!) in
            var value = currentData.value as? Int
            //check to see if the likes node exists, if not give value of 0.
            if (value == nil) {
                value = 0
            }
            currentData.value = value! + 1
            //self.PostCollectionViewDislikes.text = currentData.value as? String
            return TransactionResult.success(withValue: currentData)
            
        })
    }
    
    @IBAction func postCollectionViewCommentsButtonClicked(_ sender: Any) {
    }
    
    
}
