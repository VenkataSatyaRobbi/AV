//
//  SettingsDetailedViewController.swift
//  AmericasVision
//
//  Created by Mohan Dola on 29/09/18.
//  Copyright © 2018 zeroGravity. All rights reserved.
//

import Foundation

class SettingsDetailedViewController:UIViewController{
    
    var name = String()
    var displayText = String()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        getInfoBasedOnName()
        let label = UILabel()
        label.text = displayText
        self.view.addSubview(label)
    }
    
    func getInfoBasedOnName(){
        //Add firebase call
        displayText = "Although we may attempt to notify you when major changes are made to these Terms of Service, you should periodically review the most up-to-date version). YouTube may, in its sole discretion, modify or revise these Terms of Service and policies at any time, and you agree to be bound by such modifications or revisions. Nothing in these Terms of Service shall be deemed to confer any third-party rights or benefits."
    }
    
}
