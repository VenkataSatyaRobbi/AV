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
    var postID: String
    var userid: String
    var timestamp: Double
    var imageCourtesy: String
    var newsLocation: String
    var newsContent: String
    
    
    init(captionText: String, photoUrlString: String, postCategoryString: String, postTitleString: String, postLikesInt: NSNumber, postDislikesInt: NSNumber, postCommentsInt: NSNumber, postIDString: String, useridString: String, timeStampDouble: Double, imageCourtesyString: String, newsLocationString: String, newsContentString: String){
        caption = captionText
        photoUrl = photoUrlString
        postCategory = postCategoryString
        postTitle = postTitleString
        postLikes = postLikesInt
        postDislikes = postDislikesInt
        postComments = postCommentsInt
        postID = postIDString
        userid = useridString
        timestamp = timeStampDouble
        imageCourtesy = imageCourtesyString
        newsLocation = newsLocationString
        newsContent = newsContentString
    }
    
}
