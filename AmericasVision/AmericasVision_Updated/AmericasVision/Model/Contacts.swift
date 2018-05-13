//
//  ChatContacts.swift
//  AmericasVision
//
//  Created by Mohan Dola on 13/05/18.
//  Copyright © 2018 zeroGravity. All rights reserved.
//

import Foundation

class Contacts{
    
    private var _name = ""
    private var  _id = ""
    
    init(name:String, id:String) {
        _name = name
        _id = id
    }
    
    var name :String {
        return _name;
    }
    
    var id :String {
        return _id;
    }
    
}
