//
//  AVRootSwitcher.swift
//  AmericasVision
//
//  Created by Mohan Dola on 10/02/19.
//  Copyright © 2019 zeroGravity. All rights reserved.
//

import Foundation


class AVRootSwitcher{
    
    static let signInViewController = "SignInViewController"
    static let swRevealViewController = "SWRevealViewController"
    static let isSignIn = "isSignIn"
    
    static func updateRootViewController() {
        
        let status = UserDefaults.standard.bool(forKey: AVRootSwitcher.isSignIn)
        var rootViewController : UIViewController?
        
        if (status == true) {
            let mainStoryBoard = UIStoryboard(name: "AV", bundle: nil)
            let mainTabBarController = mainStoryBoard.instantiateViewController(withIdentifier: AVRootSwitcher.swRevealViewController) as! SWRevealViewController
            rootViewController = mainTabBarController
        } else {
            let mainStoryBoard = UIStoryboard(name: "AV", bundle: nil)
            let signInViewController = mainStoryBoard.instantiateViewController(withIdentifier: AVRootSwitcher.signInViewController) as! SignInViewController
            rootViewController = signInViewController
        }
        
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        appDelegate.window?.rootViewController = rootViewController
        
    }
}
