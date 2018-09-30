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
    var userIds = [String]()
   
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
        let user = Contacts(name: "Mohan Dola", id: "1lbnOu1kLAZwnHd4BwEDAXhKAyW2", profileImageUrl: "https://firebasestorage.googleapis.com/v0/b/americasvision-fc7ba.appspot.com/o/profileImage%2F1lbnOu1kLAZwnHd4BwEDAXhKAyW2?alt=media&token=59f51402-d6b2-4524-b338-3e5b5eefc7d8", status: "")
       DBProvider.instance.opinionRef.child(opinionId).child("voteusers").queryOrdered(byChild: "SelectedOption").queryEqual(toValue: option).observe(.childAdded) { (snapshot: DataSnapshot) in
                self.userIds.append(snapshot.key as String)
        }
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return users.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cellID", for: indexPath) as? UITableViewCell
        let contact = users[indexPath.row]
        cell?.textLabel?.text = contact.name
        cell?.imageView?.loadImageUsingCache(urlStr: contact.profileImageUrl)
        return cell!
    }
    
}
