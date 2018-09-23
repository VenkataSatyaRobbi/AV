//
//  MusicTrack.swift
//  AmericasVision
//
//  Created by Mohan Dola on 23/09/18.
//  Copyright © 2018 zeroGravity. All rights reserved.
//

import Foundation
class MusicTrack {
    
    var trackId: String
    var coverImageUrl: String
    var category: String
    var albumId: String
    var trackUrl: String
    var uploadedDate: Double
    
    init(trackId: String, coverImageUrl: String, category: String, albumId: String, trackUrl: String, uploadedDate: Double){
        self.trackId = trackId
        self.coverImageUrl = coverImageUrl
        self.category = category
        self.albumId = albumId
        self.trackUrl = trackUrl
        self.uploadedDate = uploadedDate
    }
    
}
