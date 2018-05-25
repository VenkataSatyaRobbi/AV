//
//  File.swift
//  AmericasVision
//
//  Created by Mohan Dola on 22/05/18.
//  Copyright © 2018 zeroGravity. All rights reserved.
//

import Foundation

extension UserDefaults{
    
    func setLoginUserInfo(userInfo:UserInfo){
        let encodedData: Data = NSKeyedArchiver.archivedData(withRootObject: userInfo)
        set(encodedData, forKey:Constants.LOGINUSERINFO)
        synchronize()
    }
    
    func getLoginUserInfo() -> UserInfo {
        let item = object(forKey: Constants.LOGINUSERINFO) as! Data
        return NSKeyedUnarchiver.unarchiveObject(with: item) as! UserInfo
        
    }
    
}
