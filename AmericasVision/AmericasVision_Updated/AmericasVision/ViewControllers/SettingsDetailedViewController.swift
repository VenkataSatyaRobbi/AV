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
    @IBOutlet weak var webView:UIWebView!

    override func viewDidLoad() {
        super.viewDidLoad()
        print(name)
        loadHtmlCode()
    }
    
    func loadHtmlCode() {
        webView.loadHTMLString(displayText, baseURL: nil)
    }
   
}
