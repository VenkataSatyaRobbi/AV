//
//  VotingViewController.swift
//  AmericasVision
//
//  Created by Venkata Satya R Robbi on 4/1/18.
//  Copyright © 2018 zeroGravity. All rights reserved.
//

import UIKit
import FirebaseAuth

class VotingViewController: UIViewController {
    
    @IBOutlet weak var ProfileButton: UIBarButtonItem!
    @IBOutlet weak var HomeButton: UIBarButtonItem!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor(displayP3Red: 250/255, green: 250/255, blue: 250/255, alpha: 1)
        
        navigationController?.navigationBar.tintColor = UIColor.white
        navigationController?.navigationBar.barTintColor = UIColor(displayP3Red: 34/255, green: 34/255, blue: 128/255, alpha: 1)
        
        sideMenus()
        
        // Do any additional setup after loading the view.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func Signout(_ sender: Any) {
        do {
            try Auth.auth().signOut()
        }catch let SignOutError {
            print(SignOutError)
        }
        let storyboard = UIStoryboard(name: "AV", bundle: nil)
        let signinViewController = storyboard.instantiateViewController(withIdentifier: "SignInViewController")
        self.present(signinViewController, animated: true, completion: nil)
    }
    
    func sideMenus(){
        
        if revealViewController() != nil {
            
            ProfileButton.target = revealViewController()
            ProfileButton.action = #selector(SWRevealViewController.revealToggle(_:))
            revealViewController().rearViewRevealWidth = 260
            revealViewController().rightViewRevealWidth = 260
            
            HomeButton.target = revealViewController()
            HomeButton.action = #selector(SWRevealViewController.rightRevealToggle(_:))
            
            view.addGestureRecognizer(self.revealViewController().panGestureRecognizer())
        }
    }
    
}
