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
  
    let header: UIView = {
        let header = UIImageView()
        header.image = UIImage(named: "nabar")
        header.translatesAutoresizingMaskIntoConstraints = false
        return header
    }()
    
    let profileImage: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "profile")
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    let profileBackView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    let textUserName: UITextField = {
        let userName = UITextField()
       
        userName.translatesAutoresizingMaskIntoConstraints = false
        return userName
    }()
    let textEmail: UITextField = {
        let emailText = UITextField()
        emailText.translatesAutoresizingMaskIntoConstraints = false
        return emailText
    }()
    let textPwd: UITextField = {
        let passwordText = UITextField()
        passwordText.isSecureTextEntry = true
        passwordText.translatesAutoresizingMaskIntoConstraints = false
        return passwordText
    }()
    let textConfirmPwd: UITextField = {
        let passwordconfirm = UITextField()
        passwordconfirm.isSecureTextEntry = true
        passwordconfirm.translatesAutoresizingMaskIntoConstraints = false
        return passwordconfirm
    }()
    
    let textDOB: UITextField = {
        let birthdate = UITextField()
        birthdate.translatesAutoresizingMaskIntoConstraints = false
        return birthdate
    }()
    
    let btnsubmit: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Save", for: .normal)
        button.layer.cornerRadius = 5
        button.titleLabel?.textColor = UIColor.white
        button.backgroundColor = UIColor(red: 6/255, green: 90/255, blue: 157/255, alpha: 1)
       
        return button
    }()
    
    let btnBack: UIButton = {
        let backbutton = UIButton()
        backbutton.setImage(UIImage(named: "backArrow"), for: .normal)
        backbutton.translatesAutoresizingMaskIntoConstraints = false
        return backbutton
    }()
    
    var userInfo:UserInfo!
    var DateNow: Date = Date(timeIntervalSinceNow: 0)
    var YearsFromBirth: Int = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor(red: 55/255, green:55/255, blue: 55/255, alpha: 1)
        populateUserinfo()
        sideMenus()
    }
    
    @IBAction func backAction(_ sender: Any) {
        let storyBoard : UIStoryboard = UIStoryboard(name: "AV", bundle:nil)
        let vc = storyBoard.instantiateViewController(withIdentifier: "test") as! UINavigationController
        self.present(vc, animated:true, completion:nil)
    }
    
    func populateUserinfo(){
        userInfo = UserDefaults.standard.getLoginUserInfo()
        textUserName.text = userInfo.firstName
        textEmail.text = userInfo.email
        textDOB.text = userInfo.dob
        profileImage.image = userInfo.profileImage
        
    }
    
    func sideMenus(){
        if revealViewController() != nil {
            MyProfileHomeButton.target = revealViewController()
            MyProfileHomeButton.action = #selector(SWRevealViewController.revealToggle(_:))
            revealViewController().rearViewRevealWidth = 260
            view.addGestureRecognizer(self.revealViewController().panGestureRecognizer())
        }
    }
    //6,90,157
    override func viewWillAppear(_ animated: Bool) {
        sideMenus()
        self.navigationController?.isNavigationBarHidden = true
        profileBackView.addSubview(profileImage)
        profileBackView.addSubview(textUserName)
        CommonUtils.addLineToView(view: textUserName, position:.LINE_POSITION_BOTTOM, color: UIColor(red: 6/255, green: 90/255, blue: 1157/255, alpha: 1), width: 0.5)

        profileBackView.addSubview(textEmail)
         CommonUtils.addLineToView(view: textEmail, position:.LINE_POSITION_BOTTOM, color: UIColor(red: 6/255, green: 90/255, blue: 1157/255, alpha: 1), width: 0.5)
        
        profileBackView.addSubview(textDOB)
        CommonUtils.addLineToView(view: textDOB, position:.LINE_POSITION_BOTTOM, color: UIColor(red: 6/255, green: 90/255, blue: 1157/255, alpha: 1), width: 0.5)
        
        profileBackView.addSubview(textPwd)
        CommonUtils.addLineToView(view: textPwd, position:.LINE_POSITION_BOTTOM, color: UIColor(red: 6/255, green: 90/255, blue: 1157/255, alpha: 1), width: 0.5)
        
        profileBackView.addSubview(textConfirmPwd)
         CommonUtils.addLineToView(view: textConfirmPwd, position:.LINE_POSITION_BOTTOM, color: UIColor(red: 6/255, green: 90/255, blue: 1157/255, alpha: 1), width: 0.5)
       
        profileBackView.addSubview(btnsubmit)
        self.view.addSubview(header)
       
        self.view.addSubview(profileBackView)
        self.view.addSubview(btnBack)
        //self.view.addSubview(btnBack)
        header.widthAnchor.constraint(equalToConstant: self.view.frame.width).isActive = true
        header.heightAnchor.constraint(equalToConstant: 150).isActive = true
        
        var textFieldHight = (self.view.frame.height - 150) / 5
        if textFieldHight > 60{
            textFieldHight = 60
        }
        
        
        btnBack.topAnchor.constraint(equalTo: self.view.topAnchor, constant:15).isActive = true
        btnBack.leftAnchor.constraint(equalTo: self.view.leftAnchor, constant:5).isActive = true
        btnBack.heightAnchor.constraint(equalToConstant:30).isActive = true
        btnBack.widthAnchor.constraint(equalToConstant:30).isActive = true
        btnBack.addTarget(self,action: #selector(self.backAction(_:)),for: .touchUpInside)
        
        profileImage.topAnchor.constraint(equalTo: self.view.topAnchor, constant:40).isActive = true
        profileImage.leftAnchor.constraint(equalTo: self.view.leftAnchor, constant: 130).isActive = true
        profileImage.rightAnchor.constraint(equalTo: self.view.rightAnchor, constant: -130).isActive = true
        profileImage.heightAnchor.constraint(equalToConstant: 100).isActive = true
        profileImage.widthAnchor.constraint(equalToConstant: 100).isActive = true
        profileImage.layer.cornerRadius = profileImage.frame.width + profileImage.frame.height/2;
        profileImage.layer.borderWidth = 1.5
        profileImage.layer.borderColor = UIColor.white.cgColor
        profileImage.clipsToBounds = true
   
        profileBackView.topAnchor.constraint(equalTo: self.view.topAnchor, constant:110).isActive = true
        profileBackView.leftAnchor.constraint(equalTo: self.view.leftAnchor, constant: 30).isActive = true
        profileBackView.rightAnchor.constraint(equalTo: self.view.rightAnchor, constant: -30).isActive = true
        profileBackView.backgroundColor = .white
        profileBackView.layer.cornerRadius = 12
        profileBackView.heightAnchor.constraint(equalToConstant: self.view.frame.height-130).isActive = true
        
        textUserName.topAnchor.constraint(equalTo: self.view.topAnchor, constant:170).isActive = true
        textUserName.leftAnchor.constraint(equalTo: self.view.leftAnchor, constant:50).isActive = true
        textUserName.rightAnchor.constraint(equalTo: self.view.rightAnchor, constant:-50).isActive = true
        textUserName.heightAnchor.constraint(equalToConstant:30).isActive = true
        textUserName.widthAnchor.constraint(equalToConstant:self.view.frame.width - 80).isActive = true
        
        textEmail.topAnchor.constraint(equalTo: self.view.topAnchor, constant:180 + textFieldHight).isActive = true
        textEmail.leftAnchor.constraint(equalTo: self.view.leftAnchor, constant:50).isActive = true
        textEmail.rightAnchor.constraint(equalTo: self.view.rightAnchor, constant:-50).isActive = true
        textEmail.heightAnchor.constraint(equalToConstant:30).isActive = true
        textEmail.widthAnchor.constraint(equalToConstant:self.view.frame.width - 80).isActive = true
        
        textDOB.topAnchor.constraint(equalTo: self.view.topAnchor, constant:180 + textFieldHight * 2).isActive = true
        textDOB.leftAnchor.constraint(equalTo: self.view.leftAnchor, constant:50).isActive = true
        textDOB.rightAnchor.constraint(equalTo: self.view.rightAnchor, constant:-50).isActive = true
        textDOB.heightAnchor.constraint(equalToConstant:30).isActive = true
        textDOB.widthAnchor.constraint(equalToConstant:self.view.frame.width - 80).isActive = true
        textDOB.addTarget(self,action: #selector(self.DateofBirthFieldTouched(_:)),for: .touchUpInside)
        
        textPwd.topAnchor.constraint(equalTo: self.view.topAnchor, constant:180 + textFieldHight * 3).isActive = true
        textPwd.leftAnchor.constraint(equalTo: self.view.leftAnchor, constant:50).isActive = true
        textPwd.rightAnchor.constraint(equalTo: self.view.rightAnchor, constant:-50).isActive = true
        textPwd.heightAnchor.constraint(equalToConstant:30).isActive = true
        textPwd.widthAnchor.constraint(equalToConstant:self.view.frame.width - 80).isActive = true
        textPwd.placeholder = "Password"
        
        textConfirmPwd.topAnchor.constraint(equalTo: self.view.topAnchor, constant:180 + textFieldHight * 4).isActive = true
        textConfirmPwd.leftAnchor.constraint(equalTo: self.view.leftAnchor, constant:50).isActive = true
        textConfirmPwd.rightAnchor.constraint(equalTo: self.view.rightAnchor, constant:-50).isActive = true
        textConfirmPwd.heightAnchor.constraint(equalToConstant:30).isActive = true
        textConfirmPwd.widthAnchor.constraint(equalToConstant:self.view.frame.width - 80).isActive = true
       textConfirmPwd.placeholder = "Confirm Password"
        
        btnsubmit.bottomAnchor.constraint(equalTo: self.view.bottomAnchor, constant:-30).isActive = true
        btnsubmit.leftAnchor.constraint(equalTo: self.view.leftAnchor, constant:50).isActive = true
        btnsubmit.rightAnchor.constraint(equalTo: self.view.rightAnchor, constant:-50).isActive = true
        btnsubmit.heightAnchor.constraint(equalToConstant:30).isActive = true
        btnsubmit.widthAnchor.constraint(equalToConstant:self.view.frame.width - 80).isActive = true
        btnsubmit.addTarget(self,action: #selector(self.updateProfile(_:)),for: .touchUpInside)
        
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
