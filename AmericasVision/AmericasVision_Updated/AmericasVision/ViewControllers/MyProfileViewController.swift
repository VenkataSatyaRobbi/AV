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
    
    @IBOutlet weak var textUserName: UITextField!
    @IBOutlet weak var textEmail: UITextField!
    @IBOutlet weak var textDOB: UITextField!
    @IBOutlet weak var textPwd: UITextField!
    @IBOutlet weak var textConfirmPwd: UITextField!
    
    var userInfo:UserInfo!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.white
        alignment()
        populateUserinfo()
        sideMenus()
        textUserName .isEnabled = false
        textEmail .isEnabled = false
    }
    
    func populateUserinfo(){
        userInfo = UserDefaults.standard.getLoginUserInfo()
        textUserName.text = userInfo.firstName
        textEmail.text = userInfo.email
        textDOB.text = userInfo.dob
        profileimg.image = userInfo.profileImage
        
    }
    
    func alignment(){
        let myColor : UIColor = UIColor(red: 0/255, green: 180/255, blue: 210/255, alpha: 1)
        bgview1.layer.cornerRadius = 2
        bgview1.clipsToBounds = true
        
        profileimg.layer.cornerRadius = 45
        profileimg.clipsToBounds = true
        //profileimg.layer.borderWidth = 0.5
        profileimg.layer.borderColor = myColor.cgColor
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
    }
    
    @IBAction func updateProfile(_ sender: Any) {
        DBProvider.instance.updateProfileInfo(userInfo: userInfo)
    }
    
}
