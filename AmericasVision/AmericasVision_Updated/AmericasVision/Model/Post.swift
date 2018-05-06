//
//  Post.swift
//  AmericasVision
//
//  Created by Venkata Satya R Robbi on 4/14/18.
//  Copyright © 2018 zeroGravity. All rights reserved.
//

import Foundation
class Post{
    var caption: String?
    var photoUrl: String
    var postCategory: String
    var postTitle: String
    var postLikes: NSNumber
    var postDislikes: NSNumber
    var postComments: NSNumber
    
    init(captionText: String, photoUrlString: String, postCategoryString: String, postTitleString: String, postLikesInt: NSNumber, postDislikesInt: NSNumber, postCommentsInt: NSNumber){
        caption = captionText
        photoUrl = photoUrlString
        postCategory = postCategoryString
        postTitle = postTitleString
        postLikes = postLikesInt
        postDislikes = postDislikesInt
        postComments = postCommentsInt
    }
    
}
