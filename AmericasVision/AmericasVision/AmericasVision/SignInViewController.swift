//
//  SignInViewController.swift
//  AmericasVision
//
//  Created by Venkata Satya R Robbi on 3/31/18.
//  Copyright © 2018 zeroGravity. All rights reserved.
//

import UIKit

class SignInViewController: UIViewController {

    @IBOutlet weak var emailField: UITextField!
    @IBOutlet weak var passwordField: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        emailField.backgroundColor = UIColor.clear
        emailField.tintColor = UIColor.white
        emailField.attributedPlaceholder = NSAttributedString(string: emailField.placeholder!, attributes: [NSAttributedStringKey.foregroundColor: UIColor(white: 1.0, alpha: 0.9)])
        let bottomLayerEmail = CALayer()
        bottomLayerEmail.frame = CGRect(x: 0, y: 43, width: 600 , height: 1)
        bottomLayerEmail.backgroundColor = UIColor(red: 214/255, green: 214/255, blue: 214/255, alpha: 1).cgColor
        emailField.layer.addSublayer(bottomLayerEmail)
        
        passwordField.backgroundColor = UIColor.clear
        passwordField.tintColor = UIColor.white
        passwordField.attributedPlaceholder = NSAttributedString(string: passwordField.placeholder!, attributes: [NSAttributedStringKey.foregroundColor: UIColor(white: 1.0, alpha: 0.9)])
        let bottomLayerPassword = CALayer()
        bottomLayerPassword.frame = CGRect(x: 0, y: 43, width: 600 , height: 1)
        bottomLayerPassword.backgroundColor = UIColor(red: 214/255, green: 214/255, blue: 214/255, alpha: 1).cgColor
        passwordField.layer.addSublayer(bottomLayerPassword)
        
        // Do any additional setup after loading the view.
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
