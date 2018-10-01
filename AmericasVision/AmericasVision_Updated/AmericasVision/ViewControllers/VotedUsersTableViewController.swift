//
//  VotedUsersTableViewController.swift
//  AmericasVision
//
//  Created by Mohan Dola on 22/09/18.
//  Copyright © 2018 zeroGravity. All rights reserved.
//

import Foundation
import FirebaseDatabase
import FirebaseStorage

class VotedUsersTableViewController:UITableViewController{
    
    private let cellID = "cellID"
    var users = [Contacts]()
    var option = String()
    var opinionId = String()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cellID")
        tableView.dataSource = self
        tableView.delegate = self
        tableView.tableFooterView = UIView()
        getUsers()
    }
    
    func getUsers(){
       DBProvider.instance.opinionRef.child(opinionId).child("voteusers").queryOrdered(byChild: "SelectedOption").queryEqual(toValue: option).observe(.childAdded) { (snapshot: DataSnapshot) in
        
                DBProvider.instance.userRef.child(snapshot.key as String).observe(.value) { (snapshot: DataSnapshot) in
                    if let dict = snapshot.value as? [String: Any] {
                        let name = (dict["FirstName"] as? String)! + " " + (dict["LastName"] as? String)!
                        let profileImageUrl = dict["ProfileImageURL"] as? String
                        let user = Contacts(name: name, id: snapshot.key as String, profileImageUrl: profileImageUrl!, status: "")
                        self.users.append(user)
                        self.tableView.reloadData()
                     }
                }
        }
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return users.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cellID", for: indexPath) as UITableViewCell
        let user = users[indexPath.row]
        cell.textLabel?.text = user.name
        cell.imageView?.loadImageUsingCache(urlStr: user.profileImageUrl)
        return cell
    }
    
}
