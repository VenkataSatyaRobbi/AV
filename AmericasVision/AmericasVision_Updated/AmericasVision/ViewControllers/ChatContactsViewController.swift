//
//  ChatContactsViewController.swift
//  AmericasVision
//
//  Created by Mohan Dola on 13/05/18.
//  Copyright © 2018 zeroGravity. All rights reserved.
//

import UIKit
import FirebaseDatabase

class ChatContactsViewController: UIViewController ,UITableViewDelegate, UITableViewDataSource,UISearchBarDelegate, FetchData{
    
    private let cellID = "chatContactsCell"
    private var contacts = [Contacts]();
    private var filterContacts = [Contacts]()
    private let CHAT_SEGUE = "chatsegue"
    private var selectedId = String()
    private var selectedStatus = String()

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
        fetchUserStatus()
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
        let longPressRecognizer = UILongPressGestureRecognizer(target: self, action: #selector(longPressed(sender:)))
        cell?.addGestureRecognizer(longPressRecognizer)
     
        let contact = filterContacts[indexPath.row]
      //  longPressRecognizer.tag = indexPath.row
        cell?.ChatTableViewCellUsername?.text = contact.name
        cell?.ChatTableViewCellImage.loadImageUsingCache(urlStr: contact.profileImageUrl)
        cell?.ChatTableViewCellCaption.text = contact.status
        return cell!
    }
    
    func tableView(_ tableView: UITableView,heightForRowAt indexPath: IndexPath) -> CGFloat{
        return 60
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if filterContacts[indexPath.row].status == "Accepted" {
            performSegue(withIdentifier: CHAT_SEGUE, sender: self)
        }
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
            return contact.name.lowercased().contains(text.lowercased())
        })
        contactsTable.reloadData()
    }
    
    func tableView(_ tableView: UITableView, shouldShowMenuForRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    @IBAction func longPressed(sender: UILongPressGestureRecognizer) {
        // let buttonRow = sender.tag
        let p = sender.location(in: self.contactsTable)
        
        let indexPath = self.contactsTable.indexPathForRow(at: p)
        if indexPath == nil {
            print("Long press on table view, not row.")
        }
        let contact = filterContacts[(indexPath?.row)!]
        if sender.state == UIGestureRecognizerState.began {
            longPressMenuItem(frame:(sender.view?.frame)!,contact:contact)
          sender.view?.becomeFirstResponder()
        }
    }
    
    override var canBecomeFirstResponder: Bool {
        return true
    }
    
    func longPressMenuItem(frame:CGRect,contact:Contacts){
        let myMenuController: UIMenuController = UIMenuController.shared
        myMenuController.isMenuVisible = true
        //myMenuController.arrowDirection = UIMenuControllerArrowDirection.down
        myMenuController.setTargetRect(frame, in: self.contactsTable)
        selectedId = contact.id
        selectedStatus = contact.status
        if contact.status == "Unavailable" {
            let myMenuItem_1: UIMenuItem = UIMenuItem(title: "Invite", action: #selector(ChatContactsViewController.addMessageActionTapped(sender:)))
            let myMenuItem_2: UIMenuItem = UIMenuItem(title: "Block", action: #selector(ChatContactsViewController.addMessageActionTapped(sender:)))
            let myMenuItems: NSArray = [myMenuItem_1, myMenuItem_2]
            myMenuController.menuItems = myMenuItems as? [UIMenuItem]
        }else if contact.status == "Pending" {
            let myMenuItem_1: UIMenuItem = UIMenuItem(title: "Accept", action: #selector(ChatContactsViewController.addMessageActionTapped(sender:)))
            let myMenuItem_2: UIMenuItem = UIMenuItem(title: "Block", action: #selector(ChatContactsViewController.addMessageActionTapped(sender:)))
            let myMenuItems: NSArray = [myMenuItem_1,myMenuItem_2]
            myMenuController.menuItems = myMenuItems as? [UIMenuItem]
        }else if contact.status == "Accepted" {
            let myMenuItem_1: UIMenuItem = UIMenuItem(title: "Block", action: #selector(ChatContactsViewController.addMessageActionTapped(sender:)))
            let myMenuItems: NSArray = [myMenuItem_1]
            myMenuController.menuItems = myMenuItems as? [UIMenuItem]
        }else if contact.status == "Blocked" {
            let myMenuItem_1: UIMenuItem = UIMenuItem(title: "Unblock", action: #selector(ChatContactsViewController.addMessageActionTapped(sender:)))
            let myMenuItems: NSArray = [myMenuItem_1]
            myMenuController.menuItems = myMenuItems as? [UIMenuItem]
        }
        
    }
    
    @IBAction func addMessageActionTapped(sender: UIMenuItem){
        NSLog("Invite")
        if selectedStatus == "Unavailable"{
            let status = sender.title == "Invite" ? 1: 3
            let data :Dictionary<String,Any> = [Constants.FROMID:AVAuthService.getCurrentUserId(),Constants.TOID:selectedId,Constants.STATUS:status,Constants.ACTIONID:AVAuthService.getCurrentUserId()]
            DBProvider.instance.chatStatusRef.childByAutoId().setValue((data))
        }else{
           //get the details and update the value
            let ref = DBProvider.instance.chatStatusRef
            
            if sender.title == "Accept"{
                ref.queryOrdered(byChild: Constants.TOID).queryEqual(toValue: AVAuthService.getCurrentUserId()).observe(.childAdded) { (snapshot: DataSnapshot) in
                    let key = snapshot.key as String
                    ref.child(key).updateChildValues([Constants.STATUS: 2])
                    ref.child(key).updateChildValues([Constants.ACTIONID: AVAuthService.getCurrentUserId()])
                    
                }
            }else if sender.title == "Block"{
                ref.queryOrdered(byChild: Constants.TOID).queryEqual(toValue: AVAuthService.getCurrentUserId()).observe(.childAdded) { (snapshot: DataSnapshot) in
                    let key = snapshot.key as String
                    ref.child(key).updateChildValues([Constants.STATUS: 3])
                    ref.child(key).updateChildValues([Constants.ACTIONID: AVAuthService.getCurrentUserId()])
                    
                }
            }else if sender.title == "Unblock"{
                ref.queryOrdered(byChild: Constants.TOID).queryEqual(toValue: AVAuthService.getCurrentUserId()).observe(.childAdded) { (snapshot: DataSnapshot) in
                    let key = snapshot.key as String
                    ref.child(key).updateChildValues([Constants.STATUS: 1])
                    ref.child(key).updateChildValues([Constants.ACTIONID: AVAuthService.getCurrentUserId()])
                
                }
            }
        }
    }
    
    /*
     * Unavialale->0, pending->1 ,Accepted->2,Blocked->3, Unblocked->4
     */
    func fetchUserStatus(){
        DBProvider.instance.chatStatusRef.queryOrdered(byChild: Constants.ACTIONID).queryEqual(toValue: AVAuthService.getCurrentUserId()).observeSingleEvent(of: DataEventType.value){
                (snapShot:DataSnapshot) in
                if let myContacts = snapShot.value as? NSDictionary{
                    for(_,value) in myContacts{
                        if let contactData = value as? NSDictionary{
                           let  userId = contactData[Constants.TOID] as? String
                           let  status = contactData[Constants.STATUS] as? NSNumber
                           if status == 1{
                            self.populateContacts(userId: userId!, status: "Pending")
                           }else if status == 2{
                            self.populateContacts(userId: userId!, status:"Accepted")
                           }else if status == 3{
                            self.populateContacts(userId: userId!, status:"Blocked")
                           }
                           self.contactsTable.reloadData()
                        }
                   }
                }
        }
        
        DBProvider.instance.chatStatusRef.queryOrdered(byChild: Constants.TOID).queryEqual(toValue:
            AVAuthService.getCurrentUserId()).observeSingleEvent(of: DataEventType.value){
            (snapShot:DataSnapshot) in
            if let myContacts = snapShot.value as? NSDictionary{
                for(_,value) in myContacts{
                    if let contactData = value as? NSDictionary{
                        let  userId = contactData[Constants.ACTIONID] as? String == AVAuthService.getCurrentUserId() ? contactData[Constants.FROMID] as? String : contactData[Constants.ACTIONID] as? String
                        let  status = contactData[Constants.STATUS] as? NSNumber
                        if status == 1{
                            self.populateContacts(userId: userId!, status:"Pending")
                        }else if status == 2{
                            self.populateContacts(userId: userId!, status:"Accepted")
                        }else if status == 3{
                            self.populateContacts(userId: userId!, status:"Blocked")
                        }
                        self.contactsTable.reloadData()
                    }
                }
            }
        }
    }
    
    func populateContacts(userId:String,status:String){
        for (index, contact) in contacts.enumerated() {
            if contact.id == userId {
                self.contacts[index].status = status
            }
        }
    }
    
}
