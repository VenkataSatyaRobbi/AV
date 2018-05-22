//
//  MyProfileViewController.swift
//  AmericasVision
//
//  Created by Venkata Satya R Robbi on 5/5/18.
//  Copyright © 2018 zeroGravity. All rights reserved.
//

import UIKit

class MyProfileViewController: UIViewController {

    @IBOutlet weak var MyProfileHomeButton: UIBarButtonItem!
     @IBOutlet weak var bgview: UIView!
    @IBOutlet weak var bgview1: UIView!
     @IBOutlet weak var bgview2: UIView!
     @IBOutlet weak var profileimg: UIImageView!
        @IBOutlet weak var btnsubmit: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
         let myColor : UIColor = UIColor(red: 0/255, green: 180/255, blue: 210/255, alpha: 1)
        bgview.layer.cornerRadius = 6
        bgview.clipsToBounds = true
        bgview.layer.borderWidth = 0.5
        bgview.layer.borderColor = myColor.cgColor
        
        bgview1.layer.cornerRadius = 2
        bgview1.clipsToBounds = true
        
        btnsubmit.layer.cornerRadius = 5
        btnsubmit.clipsToBounds = true
        
        bgview2.layer.cornerRadius = 2
        bgview2.clipsToBounds = true
        
        
        //bgview.layer.borderColor = myColor.cgColor
        
        profileimg.layer.cornerRadius = 50
        profileimg.clipsToBounds = true
        profileimg.layer.borderWidth = 0.5
        profileimg.layer.borderColor = myColor.cgColor
        // Do any additional setup after loading the view.
        view.backgroundColor = UIColor.white
        
        sideMenus()
    }
    
    func sideMenus(){
        
        if revealViewController() != nil {
            MyProfileHomeButton.target = revealViewController()
            MyProfileHomeButton.action = #selector(SWRevealViewController.revealToggle(_:))
            revealViewController().rearViewRevealWidth = 260
            view.addGestureRecognizer(self.revealViewController().panGestureRecognizer())
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        sideMenus()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
