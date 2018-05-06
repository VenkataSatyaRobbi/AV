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
    var rowIndex: Int!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        ProfileImage.layer.cornerRadius = ProfileImage.frame.height/2
        ProfileImage.clipsToBounds = true
        
        if Auth.auth().currentUser != nil {
            let AVDBref = Database.database().reference()
            let AVDBuserref = AVDBref.child("users")
            AVDBuserref.child((Auth.auth().currentUser?.uid)!).observe(.value) { (snapshot) in
                let FirstNameLabel = (snapshot.value as! NSDictionary)["FirstName"] as? String
                self.ProfileLabel.text = "Hi " + FirstNameLabel!
            }
        }
        
        ProfileMenuOptionsArray = ["AV News","AV Music Store","AV Market Place","AV Messaging","AV Voting Tracker","My Profile","Settings","Sign out"]
        ProfileMenuImagesArray = [UIImage(named: "newsfeed")!,UIImage(named: "music")!,UIImage(named: "marketplace")!,UIImage(named: "chat")!,UIImage(named: "voting")!,UIImage(named: "profile")!, UIImage(named: "settings")!, UIImage(named: "signout")!]
        
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
        rowIndex = indexPath.row
        if rowIndex == 7 {
            Signout()
        }
        else if rowIndex == 0 {
            self.performSegue(withIdentifier: "NewsFeedFromSideMenuSegue", sender: nil)
        }
        else if rowIndex == 1 {
            self.performSegue(withIdentifier: "MusicFromSideMenuSegue", sender: nil)
        }
        else if rowIndex == 2 {
            self.performSegue(withIdentifier: "MarketPlaceFromSideMenuSegue", sender: nil)
        }
        else if rowIndex == 3 {
            self.performSegue(withIdentifier: "ChatFromSideMenuSegue", sender: nil)
        }
        else if rowIndex == 4 {
            self.performSegue(withIdentifier: "VotesFromSideMenuSegue", sender: nil)
        }
        else if rowIndex == 5 {
            self.performSegue(withIdentifier: "MyProfileFromSideMenuSegue", sender: nil)
        }
        else if rowIndex == 6 {
            self.performSegue(withIdentifier: "NewsFeedFromSideMenuSegue", sender: nil)
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
