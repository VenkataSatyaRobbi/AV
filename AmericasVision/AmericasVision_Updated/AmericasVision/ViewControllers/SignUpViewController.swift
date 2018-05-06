//
//  SignUpViewController.swift
//  AmericasVision
//
//  Created by Venkata Satya R Robbi on 3/31/18.
//  Copyright © 2018 zeroGravity. All rights reserved.
//

import UIKit
import FirebaseAuth
import FirebaseDatabase
import FirebaseStorage

class SignUpViewController: UIViewController {
    
    @IBOutlet weak var FirstNameField: UITextField!
    @IBOutlet weak var LastNameField: UITextField!
    @IBOutlet weak var PhoneField: UITextField!
    @IBOutlet weak var EmailField: UITextField!
    @IBOutlet weak var PasswordField: UITextField!
    @IBOutlet weak var ConfirmPasswordField: UITextField!
    @IBOutlet weak var ProfilePlaceHolderImage: UIImageView!
    @IBOutlet weak var SignUpButton: UIButton!
    @IBOutlet weak var PasswordsMatchLabel: UILabel!
    @IBOutlet weak var PasswordsDonotMatchLabel: UILabel!
    var ProfileSelectedImage: UIImage?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        PasswordsDonotMatchLabel.isHidden = true
        PasswordsMatchLabel.isHidden = true
        FirstNameField.backgroundColor = UIColor.clear
        FirstNameField.tintColor = UIColor.white
        FirstNameField.attributedPlaceholder = NSAttributedString(string: FirstNameField.placeholder!, attributes: [NSAttributedStringKey.foregroundColor: UIColor(white: 1.0, alpha: 0.9)])
        let bottomLayerFirstName = CALayer()
        bottomLayerFirstName.frame = CGRect(x: 0, y: 29, width: self.view.frame.size.width - 40 , height: 1)
        bottomLayerFirstName.backgroundColor = UIColor(red: 214/255, green: 214/255, blue: 214/255, alpha: 1).cgColor
        FirstNameField.layer.addSublayer(bottomLayerFirstName)
        
        LastNameField.backgroundColor = UIColor.clear
        LastNameField.tintColor = UIColor.white
        LastNameField.attributedPlaceholder = NSAttributedString(string: LastNameField.placeholder!, attributes: [NSAttributedStringKey.foregroundColor: UIColor(white: 1.0, alpha: 0.9)])
        let bottomLayerLastName = CALayer()
        bottomLayerLastName.frame = CGRect(x: 0, y: 29, width: self.view.frame.size.width - 40 , height: 1)
        bottomLayerLastName.backgroundColor = UIColor(red: 214/255, green: 214/255, blue: 214/255, alpha: 1).cgColor
        LastNameField.layer.addSublayer(bottomLayerLastName)
        
        PhoneField.backgroundColor = UIColor.clear
        PhoneField.tintColor = UIColor.white
        PhoneField.attributedPlaceholder = NSAttributedString(string: PhoneField.placeholder!, attributes: [NSAttributedStringKey.foregroundColor: UIColor(white: 1.0, alpha: 0.9)])
        let bottomLayerPhone = CALayer()
        bottomLayerPhone.frame = CGRect(x: 0, y: 29, width: self.view.frame.size.width - 40 , height: 1)
        bottomLayerPhone.backgroundColor = UIColor(red: 214/255, green: 214/255, blue: 214/255, alpha: 1).cgColor
        PhoneField.layer.addSublayer(bottomLayerPhone)
        
        EmailField.backgroundColor = UIColor.clear
        EmailField.tintColor = UIColor.white
        EmailField.attributedPlaceholder = NSAttributedString(string: EmailField.placeholder!, attributes: [NSAttributedStringKey.foregroundColor: UIColor(white: 1.0, alpha: 0.9)])
        let bottomLayerEmail = CALayer()
        bottomLayerEmail.frame = CGRect(x: 0, y: 29, width: self.view.frame.size.width - 40 , height: 1)
        bottomLayerEmail.backgroundColor = UIColor(red: 214/255, green: 214/255, blue: 214/255, alpha: 1).cgColor
        EmailField.layer.addSublayer(bottomLayerEmail)
        
        PasswordField.backgroundColor = UIColor.clear
        PasswordField.tintColor = UIColor.white
        PasswordField.attributedPlaceholder = NSAttributedString(string: PasswordField.placeholder!, attributes: [NSAttributedStringKey.foregroundColor: UIColor(white: 1.0, alpha: 0.9)])
        let bottomLayerPassword = CALayer()
        bottomLayerPassword.frame = CGRect(x: 0, y: 29, width: self.view.frame.size.width - 40 , height: 1)
        bottomLayerPassword.backgroundColor = UIColor(red: 214/255, green: 214/255, blue: 214/255, alpha: 1).cgColor
        PasswordField.layer.addSublayer(bottomLayerPassword)
        
        ConfirmPasswordField.backgroundColor = UIColor.clear
        ConfirmPasswordField.tintColor = UIColor.white
        ConfirmPasswordField.attributedPlaceholder = NSAttributedString(string: ConfirmPasswordField.placeholder!, attributes: [NSAttributedStringKey.foregroundColor: UIColor(white: 1.0, alpha: 0.9)])
        let bottomLayerConfirmPassword = CALayer()
        bottomLayerConfirmPassword.frame = CGRect(x: 0, y: 29, width: self.view.frame.size.width - 40 , height: 1)
        bottomLayerConfirmPassword.backgroundColor = UIColor(red: 214/255, green: 214/255, blue: 214/255, alpha: 1).cgColor
        ConfirmPasswordField.layer.addSublayer(bottomLayerConfirmPassword)
        
        ProfilePlaceHolderImage.layer.cornerRadius = ProfilePlaceHolderImage.frame.height/2
        ProfilePlaceHolderImage.clipsToBounds = true
        
        let profilePhotoTapGesture = UITapGestureRecognizer(target: self, action: #selector(self.selectProfileImage))
        ProfilePlaceHolderImage.addGestureRecognizer(profilePhotoTapGesture)
        ProfilePlaceHolderImage.isUserInteractionEnabled = true
        
        SignUpButton.isEnabled = false
        checkTextField()
        // Do any additional setup after loading the view.
    }
    
    func checkTextField(){
        FirstNameField.addTarget(self, action: #selector(self.textFieldDidChange), for: UIControlEvents.editingChanged)
        LastNameField.addTarget(self, action: #selector(self.textFieldDidChange), for: UIControlEvents.editingChanged)
        PhoneField.addTarget(self, action: #selector(self.textFieldDidChange), for: UIControlEvents.editingChanged)
        EmailField.addTarget(self, action: #selector(self.textFieldDidChange), for: UIControlEvents.editingChanged)
        PasswordField.addTarget(self, action: #selector(self.textFieldDidChange), for: UIControlEvents.editingChanged)
        ConfirmPasswordField.addTarget(self, action: #selector(self.textFieldDidChange), for: UIControlEvents.editingChanged)
    }
    
    @objc func textFieldDidChange(){
        guard let FirstNameValue = FirstNameField.text, !FirstNameValue.isEmpty, let LastNameValue = LastNameField.text, !LastNameValue.isEmpty, let PhoneValue = PhoneField.text, !PhoneValue.isEmpty, let EmailValue = EmailField.text, !EmailValue.isEmpty, let PasswordValue = PasswordField.text, !PasswordValue.isEmpty, let ConfirmPasswordValue = ConfirmPasswordField.text, !ConfirmPasswordValue.isEmpty else {
            PasswordsDonotMatchLabel.isHidden = true
            PasswordsMatchLabel.isHidden = true
            SignUpButton.setTitleColor(UIColor.lightText, for: UIControlState.normal)
            SignUpButton.isEnabled = false
            return
        }
        if ConfirmPasswordValue == PasswordValue{
            PasswordsMatchLabel.isHidden = false
            PasswordsDonotMatchLabel.isHidden = true
            PasswordsMatchLabel.textColor = .green
        SignUpButton.setTitleColor(UIColor.white, for: UIControlState.normal)
        SignUpButton.isEnabled = true
        }else{
            PasswordsDonotMatchLabel.isHidden = false
            PasswordsMatchLabel.isHidden = true
            PasswordsDonotMatchLabel.textColor = .red
            SignUpButton.setTitleColor(UIColor.lightText, for: UIControlState.normal)
            SignUpButton.isEnabled = false
        }
    }
    
    @objc func selectProfileImage() {
        let profileImagePickerController = UIImagePickerController()
        profileImagePickerController.delegate = self
        present(profileImagePickerController, animated: true, completion: nil)
    }
    
    @IBAction func ExistingUserDismissScreen(_ sender: UIButton) {
        dismiss(animated: true, completion: nil)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        view.endEditing(true)
    }
    
    
    @IBAction func SignUpClickTouchUpInside(_ sender: UIButton) {
        view.endEditing(true)
        ProgressHUD.show("Registering..", interaction: false)
        if let ProfilePlaceHolderImg = self.ProfileSelectedImage, let imageData = UIImageJPEGRepresentation(ProfilePlaceHolderImg, 0.1) {
            AVAuthService.signUp(firstname: FirstNameField.text!, lastname: LastNameField.text!, phone: PhoneField.text!, email: EmailField.text!, password: PasswordField.text!, confirmpassword: ConfirmPasswordField.text!, imagedata: imageData, onSuccess: {
                ProgressHUD.showSuccess("Welcome")
                self.performSegue(withIdentifier: "showTabBarHomePageFromSignUp", sender: nil)
            }, onError: {
                (errorString) in
                ProgressHUD.showError(errorString!)
            })
        }else {
            ProgressHUD.showError("Profile photo cannot be blank")
            }
    }
}

extension SignUpViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        if let profieImage = info["UIImagePickerControllerOriginalImage"] as? UIImage {
            ProfileSelectedImage = profieImage
            ProfilePlaceHolderImage.image = profieImage
        }
        dismiss(animated: true, completion: nil)
    }
}
