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
    var DateNow: Date = Date(timeIntervalSinceNow: 0)
    var YearsFromBirth: Int = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.white
        alignment()
        populateUserinfo()
        sideMenus()
        textUserName .isEnabled = false
        textEmail .isEnabled = false
        textPwd.isSecureTextEntry = true
        textConfirmPwd.isSecureTextEntry = true
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
    
    @IBAction func DateofBirthFieldTouched(_ sender: Any) {
        let dateofBirthPickerView: UIDatePicker = UIDatePicker()
        dateofBirthPickerView.maximumDate = Date()
        dateofBirthPickerView.datePickerMode = UIDatePickerMode.date
        textDOB.inputView = dateofBirthPickerView
        dateofBirthPickerView.addTarget(self, action: #selector(self.datePickerFromValueChanged), for: UIControlEvents.valueChanged)
    }
    
    @objc func datePickerFromValueChanged(sender:UIDatePicker) {
        let dateofBirthDateFormatter = DateFormatter()
        dateofBirthDateFormatter.dateFormat = "dd-MM-yyyy"
        dateofBirthDateFormatter.dateStyle = .medium
        textDOB.text = dateofBirthDateFormatter.string(from: sender.date)
        let DateofBirthDate = dateofBirthDateFormatter.date(from: textDOB.text!)
        let dateComponentsFormatter = DateComponentsFormatter()
        dateComponentsFormatter.allowedUnits = [NSCalendar.Unit.minute,NSCalendar.Unit.hour,NSCalendar.Unit.day]
        
        let interval =  DateNow.timeIntervalSince(DateofBirthDate!)
        print("interval...\(interval)")
        let DateDiff = dateComponentsFormatter.string(from: interval)!
        print("difference..\(DateDiff)")
        
        if (DateDiff.contains("d")){
            let day = DateDiff.substring(to: (DateDiff.range(of: "d")?.lowerBound)!)
            YearsFromBirth  = Int( day.replacingOccurrences(of: ",", with: ""))!/365
            print("Years From Birth ...\(YearsFromBirth)")
        }
        textDOB.resignFirstResponder()
    }
    
    @IBAction func updateProfile(_ sender: Any) {
        if(YearsFromBirth <= 18){
            let errorAlert = UIAlertController(title: "Errors",
                                               message: "Your Age must be more then 18 years", preferredStyle: .alert)
            errorAlert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            self.present(errorAlert, animated: true, completion: nil)
        }else if (textPwd.text?.isEmpty)! || (textConfirmPwd.text?.isEmpty)! {
            let resetEmailSentAlert = UIAlertController(title: "Errors", message: "Please enter Passoword and Confirm Password", preferredStyle: .alert)
            resetEmailSentAlert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            self.present(resetEmailSentAlert, animated: true, completion: nil)
            
        }else if textPwd.text != textConfirmPwd.text {
           
            let errorAlert = UIAlertController(title: "Errors",
                                               message: "Confirm password mismatch", preferredStyle: .alert)
            errorAlert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            self.present(errorAlert, animated: true, completion: nil)
        }
        else{
            updateProfile()
        }
    }
    
    func updateProfile(){
        let imageData = UIImageJPEGRepresentation(userInfo.profileImage, 0.1)
        AVAuthService.updateUserProfile(phone: userInfo.phone!, dob: textDOB.text!, email: userInfo.email!, password: textPwd.text!, confirmpassword: textConfirmPwd.text!, imagedata: imageData!, onSuccess: {
            let successAlert = UIAlertController(title: "Success",
                                               message: "Profile updated succesfully.", preferredStyle: .alert)
            successAlert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            self.present(successAlert, animated: true, completion: nil)
            
        }, onError: {
            (errorString) in
            print(errorString!)
        })
    }
    
}
