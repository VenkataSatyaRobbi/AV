//
//  Post.swift
//  AmericasVision
//
//  Created by Venkata Satya R Robbi on 4/14/18.
//  Copyright © 2018 zeroGravity. All rights reserved.
//

import Foundation
class Post{
    var caption: String
    var photoUrl: String
    var postCategory: String
    var postTitle: String
    var postLikes: Int
    var postDislikes: Int
    var postComments: Int
    
    init(captionText: String, photoUrlString: String, postCategoryString: String, postTitleString: String, postLikesInt: Int, postDislikesInt: Int, postCommentsInt: Int){
        caption = captionText
        photoUrl = photoUrlString
        postCategory = postCategoryString
        postTitle = postTitleString
        postLikes = postLikesInt
        postDislikes = postDislikesInt
        postComments = postCommentsInt
    }
    
}
