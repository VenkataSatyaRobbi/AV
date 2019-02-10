//
//  ChatTabBarController.swift
//  AmericasVision
//
//  Created by Mohan Dola on 04/02/19.
//  Copyright © 2019 zeroGravity. All rights reserved.
//

import Foundation

extension UIImage {
    func createSelectionIndicator(color: UIColor, size: CGSize, lineWidth: CGFloat) -> UIImage {
        UIGraphicsBeginImageContextWithOptions(size, false, 0)
        color.setFill()
        UIRectFill(CGRect(x: 0, y: size.height - lineWidth, width: size.width, height: lineWidth))
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return image!
    }
}

class ChatTabBarController: UITabBarController{
    
    @IBOutlet weak var chatTabBar: UITabBar!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tabBar.barTintColor = UIColor.lightGray
        let indicatorColor:UIColor = UIColor(red: 6/255, green: 90/255, blue: 157/255, alpha: 1)
        self.tabBar.selectionIndicatorImage = UIImage().createSelectionIndicator(color: indicatorColor, size: CGSize(width: tabBar.frame.width/CGFloat(tabBar.items!.count), height:  30), lineWidth: 2.0)
        self.tabBar.tintColor = UIColor(red: 6/255, green: 90/255, blue: 157/255, alpha: 1)
        let font:CGFloat = 30
        self.tabBarItem.setTitleTextAttributes([NSAttributedStringKey.font: font], for: .normal)
   }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        let yStatusBar = UIApplication.shared.statusBarFrame.size.height
        let y:CGFloat = yStatusBar + self.chatTabBar.frame.size.height
        let width:CGFloat = self.chatTabBar.frame.size.width
        self.chatTabBar.frame = CGRect( x: 0, y: y-5, width: width, height: 30)
        
    }
    
}
