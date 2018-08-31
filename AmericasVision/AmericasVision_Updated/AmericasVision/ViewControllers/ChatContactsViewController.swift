//
//  ChatContactsViewController.swift
//  AmericasVision
//
//  Created by Mohan Dola on 13/05/18.
//  Copyright © 2018 zeroGravity. All rights reserved.
//

import UIKit

class ChatContactsViewController: UIViewController ,UITableViewDelegate, UITableViewDataSource,UISearchBarDelegate, FetchData{
    
    private let cellID = "chatContactsCell"
    private var contacts = [Contacts]();
    private var filterContacts = [Contacts]();
    private let CHAT_SEGUE = "chatsegue"

    @IBOutlet weak var contactsTable: UITableView!
    @IBOutlet weak var ChatPrivateHomeButton: UIBarButtonItem!
    @IBOutlet weak var searchBar: UISearchBar!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        sideMenus()
        self.navigationItem.title = "Contacts"
        DBProvider.instance.delegate = self
        DBProvider.instance.getContacts()
        searchBar.delegate = self
    }
    
    func dataReceived(contacts: [Contacts]) {
        self.contacts = contacts
        self.filterContacts = contacts
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
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return filterContacts.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellID, for: indexPath) as? ChatTableViewCell
        let contact = filterContacts[indexPath.row]
        cell?.ChatTableViewCellUsername?.text = contact.name
        cell?.ChatTableViewCellImage.loadImageUsingCache(urlStr: contact.profileImageUrl)
        return cell!
    }
    
    func tableView(_ tableView: UITableView,heightForRowAt indexPath: IndexPath) -> CGFloat{
        return 60
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: CHAT_SEGUE, sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let index = self.contactsTable.indexPathForSelectedRow
        let indexNumber = index?.row
        let vc: ChatPrivateViewController = segue.destination as! ChatPrivateViewController
        vc.contact = contacts[indexNumber!]
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        guard !searchText.isEmpty else{
            filterContacts = contacts
            contactsTable.reloadData()
            return
        }
        filterContacts = contacts.filter({contact -> Bool in
            guard let text = searchBar.text else {return false}
            return contact.name.contains(text)
        })
        contactsTable.reloadData()
    }
    
}
