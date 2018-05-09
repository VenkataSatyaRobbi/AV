//
//  SignInViewController.swift
//  AmericasVision
//
//  Created by Venkata Satya R Robbi on 3/31/18.
//  Copyright © 2018 zeroGravity. All rights reserved.
//

import UIKit
import FirebaseAuth
import FBSDKLoginKit

class SignInViewController: UIViewController {
    
    @IBOutlet weak var emailField: UITextField!
    @IBOutlet weak var passwordField: UITextField!
    @IBOutlet weak var signInButton: UIButton!
    
    @IBOutlet weak var SignInwFBButton: FBSDKLoginButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        emailField.backgroundColor = UIColor.clear
        emailField.tintColor = UIColor.white
        emailField.attributedPlaceholder = NSAttributedString(string: emailField.placeholder!, attributes: [NSAttributedStringKey.foregroundColor: UIColor(white: 1.0, alpha: 1)])
        let bottomLayerEmail = CALayer()
        bottomLayerEmail.frame = CGRect(x: 0, y: 44, width: self.view.frame.size.width - 40 , height: 1)
        bottomLayerEmail.backgroundColor = UIColor(red: 214/255, green: 214/255, blue: 214/255, alpha: 1).cgColor
        emailField.layer.addSublayer(bottomLayerEmail)
        
        passwordField.backgroundColor = UIColor.clear
        passwordField.tintColor = UIColor.white
        passwordField.attributedPlaceholder = NSAttributedString(string: passwordField.placeholder!, attributes: [NSAttributedStringKey.foregroundColor: UIColor(white: 1.0, alpha: 1)])
        let bottomLayerPassword = CALayer()
        bottomLayerPassword.frame = CGRect(x: 0, y: 44, width: self.view.frame.size.width - 40 , height: 1)
        bottomLayerPassword.backgroundColor = UIColor(red: 214/255, green: 214/255, blue: 214/255, alpha: 1).cgColor
        passwordField.layer.addSublayer(bottomLayerPassword)
        
        signInButton.isEnabled = false
        checkTextField()
        
        //SignInwFBButton.delegate = self
        //SignInwFBButton.readPermissions = ["public_profile"]
        // Do any additional setup after loading the view.
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        if Auth.auth().currentUser != nil {
            self.performSegue(withIdentifier: "showTabBarHomePageFromSignIn", sender: nil)
        }
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        view.endEditing(true)
    }
    
   /* func loginButton(_ loginButton: FBSDKLoginButton!, didCompleteWith result: FBSDKLoginManagerLoginResult!, error: Error!) {
        if  error != nil{
            print(error.localizedDescription)
            return
        }
        if (result.token) != nil{
            let token:FBSDKAccessToken = result.token
            print(FBSDKAccessToken.current().tokenString)
            
            let loggedInPage = self.storyboard?.instantiateViewController(withIdentifier: "AVtabBarcontroller") as! UITabBarController
            
            /*let loggedInPageView = UINavigationController(rootViewController: loggedInPage)
            
            let appdelegate = UIApplication.shared.delegate as! AppDelegate
            appdelegate.window?.rootViewController = loggedInPageView*/
        }
    }
    
    func loginButtonDidLogOut(_ loginButton: FBSDKLoginButton!) {
        
    }
    */
    func checkTextField(){
        emailField.addTarget(self, action: #selector(self.textFieldDidChange), for: UIControlEvents.editingChanged)
        passwordField.addTarget(self, action: #selector(self.textFieldDidChange), for: UIControlEvents.editingChanged)
    }
    
    @objc func textFieldDidChange(){
        guard let emailValue = emailField.text, !emailValue.isEmpty, let passwordValue = passwordField.text, !passwordValue.isEmpty else {
            signInButton.setTitleColor(UIColor.lightText, for: UIControlState.normal)
            signInButton.isEnabled = false
            return
        }
        signInButton.setTitleColor(UIColor.white, for: UIControlState.normal)
        signInButton.isEnabled = true
    }
    
    
    @IBAction func SignInClickTouchUpInside(_ sender: Any) {
        view.endEditing(true)
        ProgressHUD.show("Signing in..", interaction: false)
        AVAuthService.signIn(email: emailField.text!, password: passwordField.text!, onSuccess: {
            ProgressHUD.showSuccess("Welcome")
            self.performSegue(withIdentifier: "showTabBarHomePageFromSignIn", sender: nil)
        }, onError: { error in
            ProgressHUD.showError(error!)
            //print(error!)
        })
        
    }
    

    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
