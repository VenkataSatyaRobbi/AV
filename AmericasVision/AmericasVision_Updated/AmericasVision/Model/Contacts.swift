//
//  ChatContacts.swift
//  AmericasVision
//
//  Created by Mohan Dola on 13/05/18.
//  Copyright © 2018 zeroGravity. All rights reserved.
//

import Foundation

class Contacts{
    
    var _name = ""
    var  _id = ""
    var _profileImageUrl: String = ""
    var _status = ""
    var _latestComment = ""
    var _latestCommentDate = ""
    
    init(name:String, id:String,profileImageUrl:String,status:String) {
        _name = name
        _id = id
        _profileImageUrl = profileImageUrl
        _status = status
        _latestComment = ""
        _latestCommentDate = ""
    }
    
    var name :String {
        return _name;
    }
    
    var id :String {
        return _id;
    }
    
    var profileImageUrl :String {
        return _profileImageUrl;
    }
    
    var status:String {
        get{
          return _status
        }
        set(value){
            _status = value
        }
    }
    
    var latestComment:String {
        get{
            return _latestComment
        }
        set(value){
            _latestComment = value
        }
    }
    
    var latestCommentDate:String {
        get{
            return _latestCommentDate
        }
        set(value){
            _latestCommentDate = value
        }
    }
    
}
