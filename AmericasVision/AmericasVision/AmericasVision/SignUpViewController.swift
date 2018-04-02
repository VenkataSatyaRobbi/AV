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

class SignUpViewController: UIViewController {

    @IBOutlet weak var FirstNameField: UITextField!
    @IBOutlet weak var LastNameField: UITextField!
    @IBOutlet weak var AddressField: UITextField!
    @IBOutlet weak var CityField: UITextField!
    @IBOutlet weak var StateField: UITextField!
    @IBOutlet weak var ZipField: UITextField!
    @IBOutlet weak var PhoneField: UITextField!
    @IBOutlet weak var EmailField: UITextField!
    @IBOutlet weak var PasswordField: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        FirstNameField.backgroundColor = UIColor.clear
        FirstNameField.tintColor = UIColor.white
        FirstNameField.attributedPlaceholder = NSAttributedString(string: FirstNameField.placeholder!, attributes: [NSAttributedStringKey.foregroundColor: UIColor(white: 1.0, alpha: 0.9)])
        let bottomLayerFirstName = CALayer()
        bottomLayerFirstName.frame = CGRect(x: 0, y: 29, width: 600 , height: 1)
        bottomLayerFirstName.backgroundColor = UIColor(red: 214/255, green: 214/255, blue: 214/255, alpha: 1).cgColor
        FirstNameField.layer.addSublayer(bottomLayerFirstName)
        
        LastNameField.backgroundColor = UIColor.clear
        LastNameField.tintColor = UIColor.white
        LastNameField.attributedPlaceholder = NSAttributedString(string: LastNameField.placeholder!, attributes: [NSAttributedStringKey.foregroundColor: UIColor(white: 1.0, alpha: 0.9)])
        let bottomLayerLastName = CALayer()
        bottomLayerLastName.frame = CGRect(x: 0, y: 29, width: 600 , height: 1)
        bottomLayerLastName.backgroundColor = UIColor(red: 214/255, green: 214/255, blue: 214/255, alpha: 1).cgColor
        LastNameField.layer.addSublayer(bottomLayerLastName)

        AddressField.backgroundColor = UIColor.clear
        AddressField.tintColor = UIColor.white
        AddressField.attributedPlaceholder = NSAttributedString(string: AddressField.placeholder!, attributes: [NSAttributedStringKey.foregroundColor: UIColor(white: 1.0, alpha: 0.9)])
        let bottomLayerAddress = CALayer()
        bottomLayerAddress.frame = CGRect(x: 0, y: 29, width: 600 , height: 1)
        bottomLayerAddress.backgroundColor = UIColor(red: 214/255, green: 214/255, blue: 214/255, alpha: 1).cgColor
        AddressField.layer.addSublayer(bottomLayerAddress)
        
        CityField.backgroundColor = UIColor.clear
        CityField.tintColor = UIColor.white
        CityField.attributedPlaceholder = NSAttributedString(string: CityField.placeholder!, attributes: [NSAttributedStringKey.foregroundColor: UIColor(white: 1.0, alpha: 0.9)])
        let bottomLayerCity = CALayer()
        bottomLayerCity.frame = CGRect(x: 0, y: 29, width: 600 , height: 1)
        bottomLayerCity.backgroundColor = UIColor(red: 214/255, green: 214/255, blue: 214/255, alpha: 1).cgColor
        CityField.layer.addSublayer(bottomLayerCity)
        
        StateField.backgroundColor = UIColor.clear
        StateField.tintColor = UIColor.white
        StateField.attributedPlaceholder = NSAttributedString(string: StateField.placeholder!, attributes: [NSAttributedStringKey.foregroundColor: UIColor(white: 1.0, alpha: 0.9)])
        let bottomLayerState = CALayer()
        bottomLayerState.frame = CGRect(x: 0, y: 29, width: 600 , height: 1)
        bottomLayerState.backgroundColor = UIColor(red: 214/255, green: 214/255, blue: 214/255, alpha: 1).cgColor
        StateField.layer.addSublayer(bottomLayerState)
        
        ZipField.backgroundColor = UIColor.clear
        ZipField.tintColor = UIColor.white
        ZipField.attributedPlaceholder = NSAttributedString(string: ZipField.placeholder!, attributes: [NSAttributedStringKey.foregroundColor: UIColor(white: 1.0, alpha: 0.9)])
        let bottomLayerZip = CALayer()
        bottomLayerZip.frame = CGRect(x: 0, y: 29, width: 600 , height: 1)
        bottomLayerZip.backgroundColor = UIColor(red: 214/255, green: 214/255, blue: 214/255, alpha: 1).cgColor
        ZipField.layer.addSublayer(bottomLayerZip)
        
        PhoneField.backgroundColor = UIColor.clear
        PhoneField.tintColor = UIColor.white
        PhoneField.attributedPlaceholder = NSAttributedString(string: PhoneField.placeholder!, attributes: [NSAttributedStringKey.foregroundColor: UIColor(white: 1.0, alpha: 0.9)])
        let bottomLayerPhone = CALayer()
        bottomLayerPhone.frame = CGRect(x: 0, y: 29, width: 600 , height: 1)
        bottomLayerPhone.backgroundColor = UIColor(red: 214/255, green: 214/255, blue: 214/255, alpha: 1).cgColor
        PhoneField.layer.addSublayer(bottomLayerPhone)
        
        EmailField.backgroundColor = UIColor.clear
        EmailField.tintColor = UIColor.white
        EmailField.attributedPlaceholder = NSAttributedString(string: EmailField.placeholder!, attributes: [NSAttributedStringKey.foregroundColor: UIColor(white: 1.0, alpha: 0.9)])
        let bottomLayerEmail = CALayer()
        bottomLayerEmail.frame = CGRect(x: 0, y: 29, width: 600 , height: 1)
        bottomLayerEmail.backgroundColor = UIColor(red: 214/255, green: 214/255, blue: 214/255, alpha: 1).cgColor
        EmailField.layer.addSublayer(bottomLayerEmail)
        
        PasswordField.backgroundColor = UIColor.clear
        PasswordField.tintColor = UIColor.white
        PasswordField.attributedPlaceholder = NSAttributedString(string: PasswordField.placeholder!, attributes: [NSAttributedStringKey.foregroundColor: UIColor(white: 1.0, alpha: 0.9)])
        let bottomLayerPassword = CALayer()
        bottomLayerPassword.frame = CGRect(x: 0, y: 29, width: 600 , height: 1)
        bottomLayerPassword.backgroundColor = UIColor(red: 214/255, green: 214/255, blue: 214/255, alpha: 1).cgColor
        PasswordField.layer.addSublayer(bottomLayerPassword)
  
        // Do any additional setup after loading the view.
    }

    
    @IBAction func SignUpClickTouchUpInside(_ sender: UIButton) {
        if (FirstNameField.text != nil && LastNameField.text != nil && AddressField.text != nil && CityField.text != nil && StateField.text != nil && ZipField.text != nil && PhoneField.text != nil && EmailField.text != nil && PasswordField.text != nil){
            Auth.auth().createUser(withEmail: EmailField.text!, password: PasswordField.text!) { (user, error) in
                if error != nil{
                    print(error!.localizedDescription)
                    return
                }
                let AVDBref = Database.database().reference()
                print(AVDBref.description())
                let AVDBuserref = AVDBref.child("users")
                print(AVDBuserref.description())
                let AVDBuserid = user?.uid
                let AVDBnewuserref = AVDBuserref.child(AVDBuserid!)
                AVDBnewuserref.setValue(["FirstName": self.FirstNameField.text!, "LastName":self.LastNameField.text!, "Address": self.AddressField.text!, "City": self.CityField.text!, "State": self.StateField.text!, "Zip": self.ZipField.text!, "Phone": self.PhoneField.text!, "Email": self.EmailField.text! ])
                print("description: \(AVDBnewuserref.description())")
            }
        }
        else {
            let signupAlert = UIAlertController(title: "Missing Information", message: "All fields are mandatory for registration", preferredStyle: .alert)
            
            signupAlert.addAction(UIAlertAction(title: "Yes", style: .default, handler: nil))
            signupAlert.addAction(UIAlertAction(title: "No", style: .cancel, handler: nil))
            
            self.present(signupAlert, animated: true)
            
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func alreadyHaveAnAccount(_ sender: UIButton) {
        dismiss(animated: true, completion: nil)
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
