//
//  MusicAlbum.swift
//  AmericasVision
//
//  Created by Mohan Dola on 19/08/18.
//  Copyright © 2018 zeroGravity. All rights reserved.
//

import Foundation

class MusicAlbum{
    
    var name: String
    var coverImageUrl: String
    var category: String
    var albumId: String
    var uploadedUserId: String
    var uploadedDate: Double
    
    init(name: String, coverImageUrl: String, category: String, albumId: String, uploadedUserId: String,  uploadedDate: Double){
        self.name = name
        self.coverImageUrl = coverImageUrl
        self.category = category
        self.albumId = albumId
        self.uploadedUserId = uploadedUserId
        self.uploadedDate = uploadedDate
    }
    
}

