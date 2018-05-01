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
    @IBOutlet weak var ProfileLabel: UILabel!
    var ProfileMenuOptionsArray: Array = [String]()
    var ProfileMenuImagesArray: Array = [UIImage]()
    var rowNumber: Int!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        ProfileImage.layer.cornerRadius = ProfileImage.frame.height/2
        ProfileImage.clipsToBounds = true
        
        ProfileMenuOptionsArray = ["My Profile","Settings","Sign out"]
        ProfileMenuImagesArray = [UIImage(named: "profileselected")!, UIImage(named: "settings")!, UIImage(named: "signout")!]
        
        if Auth.auth().currentUser != nil {
            let AVStorageRef = Storage.storage().reference(forURL: PropertyConfig.FIRSTORAGE_ROOT_REF).child("profileImage").child((Auth.auth().currentUser?.uid)!)
            AVStorageRef.downloadURL { (url, error) in
                if error != nil{
                    print(error?.localizedDescription as Any)
                    return
                }
                URLSession.shared.dataTask(with: url!, completionHandler: { (data, response, error) in
                    if error != nil {
                        print(error?.localizedDescription as Any)
                        return
                    }
                    guard let imageData = UIImage(data: data!) else { return }
                    DispatchQueue.main.async {
                        self.ProfileImage.image = imageData
                    }
                    
                }).resume()
            }
            
            
        }
        
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
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        rowNumber = indexPath.row
        if rowNumber == 2 {
            Signout()
        }
    }
    
    func Signout() {
        do {
            try Auth.auth().signOut()
        }catch let SignOutError {
            print(SignOutError)
        }
        let storyboard = UIStoryboard(name: "AV", bundle: nil)
        let signinViewController = storyboard.instantiateViewController(withIdentifier: "SignInViewController")
        self.present(signinViewController, animated: true, completion: nil)
    }
    
    
}


/*extension UIImageView{
 func downloadImage(from imageURL: String){
 let url = URLRequest(url: URL(string: imageURL)!)
 
 let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
 if error != nil{
 print(error!)
 return
 }
 DispatchQueue.main.async {
 self.image = UIImage(data: data!)
 }
 }
 task.resume()
 }
 }*/
