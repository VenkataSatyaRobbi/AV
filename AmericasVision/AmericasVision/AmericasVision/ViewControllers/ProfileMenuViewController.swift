//
//  ProfileMenuViewController.swift
//  AmericasVision
//
//  Created by Venkata Satya R Robbi on 4/8/18.
//  Copyright © 2018 zeroGravity. All rights reserved.
//

import UIKit
import FirebaseAuth
import FirebaseDatabase
import FirebaseStorage

class ProfileMenuViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var ProfileImage: UIImageView!
    var ProfileMenuOptionsArray: Array = [String]()
    var ProfileMenuImagesArray: Array = [UIImage]()
    
    var firdatabaseRef: DatabaseReference!{
        return Database.database().reference()
    }
    var firstorageRef: Storage{
        return Storage.storage()
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        ProfileImage.layer.cornerRadius = ProfileImage.frame.height/2
        ProfileImage.clipsToBounds = true
        
        ProfileMenuOptionsArray = ["My Profile","Settings","Sign out"]
        ProfileMenuImagesArray = [UIImage(named: "profileselected")!, UIImage(named: "settings")!, UIImage(named: "signout")!]
        
        // Do any additional setup after loading the view.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return ProfileMenuOptionsArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let ProfileMenuCell = tableView.dequeueReusableCell(withIdentifier: "ProfileMenuTableViewCell") as! ProfileMenuTableViewCell
        ProfileMenuCell.ProfileMenuImage.image = ProfileMenuImagesArray[indexPath.row]
        ProfileMenuCell.ProfileMenuOptionName.text = ProfileMenuOptionsArray[indexPath.row]
        
        return ProfileMenuCell
    }
    
    
    /*func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
     self.performSegue(withIdentifier: <#T##String#>, sender: <#T##Any?#>)
     }*/
    
}
