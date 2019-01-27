//
//  PostComment.swift
//  AmericasVision
//
//  Created by Mohan Dola on 30/08/18.
//  Copyright © 2018 zeroGravity. All rights reserved.
//

import Foundation

class PostComment{
    
    var profileImageUrl: String
    var userId: String
    var type: String
    var comments: String
    var commentDate:Double
    var userFullName: String
    
    
    init(profileImageUrl:String, userId: String, type: String, comments: String, commentDate: Double,fullName: String){
        self.profileImageUrl = profileImageUrl
        self.userId = userId
        self.type = type
        self.comments = comments
        self.commentDate = commentDate
        self.userFullName = fullName
    }
    
}


