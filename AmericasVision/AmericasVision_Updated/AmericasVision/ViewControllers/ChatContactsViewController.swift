//
//  ChatContactsViewController.swift
//  AmericasVision
//
//  Created by Mohan Dola on 13/05/18.
//  Copyright © 2018 zeroGravity. All rights reserved.
//

import UIKit

class ChatContactsViewController: UIViewController ,UITableViewDelegate, UITableViewDataSource, FetchData{
    
    private let cellID = "chatContactsCell"
    private var contacts = [Contacts]();
    private let CHAT_SEGUE = "chatsegue"

    @IBOutlet weak var contactsTable: UITableView!
    @IBOutlet weak var ChatPrivateHomeButton: UIBarButtonItem!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        sideMenus()
        DBProvider.instance.delegate = self
        DBProvider.instance.getContacts()
    }
    
    func dataReCeived(contacts: [Contacts]) {
        self.contacts = contacts
        for contact in contacts {
            if contact.id == AVAuthService.getCurrentUserId() {
               AVAuthService.username = contact.name
            }
        }
        contactsTable.reloadData()
    }
    func sideMenus(){
        if revealViewController() != nil {
            ChatPrivateHomeButton.target = revealViewController()
            ChatPrivateHomeButton.action = #selector(SWRevealViewController.revealToggle(_:))
            revealViewController().rearViewRevealWidth = 260
            view.addGestureRecognizer(self.revealViewController().panGestureRecognizer())
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return contacts.count
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return contacts.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellID, for: indexPath) as? ChatTableViewCell
        cell?.ChatTableViewCellUsername?.text = contacts[indexPath.row].name
        return cell!
    }
    
    func tableView(_ tableView: UITableView,heightForRowAt indexPath: IndexPath) -> CGFloat{
        return 60
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: CHAT_SEGUE, sender: nil)
    }
  
}
