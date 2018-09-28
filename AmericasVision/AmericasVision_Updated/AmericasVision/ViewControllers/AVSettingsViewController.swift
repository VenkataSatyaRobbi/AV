//
//  AVSettingsViewController.swift
//  AmericasVision
//
//  Created by Mohan Dola on 09/09/18.
//  Copyright © 2018 zeroGravity. All rights reserved.
//

import Foundation

class AVSettingsViewController:UIViewController,UITableViewDataSource,UITableViewDelegate{
    
    @IBOutlet weak var homeButton: UIBarButtonItem!
    
    @IBOutlet weak var settingsTableview: UITableView!
    
    let settings = ["Do not disturb","Notification", "Privacy policy", "Terms of use","Rate & Feedback","Company Info","Version","Get Help"]
    let cellReuseIdentifier = "SettingCell"
    
    let disturbSwitch: UISwitch = {
        let sc = UISwitch()
        sc.translatesAutoresizingMaskIntoConstraints = false
        sc.onTintColor = .blue
        return sc
    }()
    
    let notificationSwitch: UISwitch = {
        let sc = UISwitch()
        sc.onTintColor = .blue
        sc.translatesAutoresizingMaskIntoConstraints = false
        return sc
    }()
    
    func sideMenus(){
        if revealViewController() != nil {
            homeButton.target = revealViewController()
            homeButton.action = #selector(SWRevealViewController.revealToggle(_:))
            revealViewController().rearViewRevealWidth = 260
            view.addGestureRecognizer(self.revealViewController().panGestureRecognizer())
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        sideMenus()
        self.navigationItem.title = "User Preferences"
        settingsTableview.register(UITableViewCell.self, forCellReuseIdentifier: cellReuseIdentifier)
        settingsTableview.delegate = self
        settingsTableview.dataSource = self
        disturbSwitch.addTarget(self, action:#selector(AVSettingsViewController.categorySwitchValueChanged(_:)), for: .valueChanged)
        notificationSwitch.addTarget(self, action:#selector(AVSettingsViewController.categorySwitchValueChanged(_:)), for: .valueChanged)
    }
    
    func getSettingInfo(){
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return settings.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell:UITableViewCell = settingsTableview.dequeueReusableCell(withIdentifier: cellReuseIdentifier) as UITableViewCell!
        cell.textLabel?.text = settings[indexPath.row]
        if settings[indexPath.row] == "Do not disturb" {
            cell.contentView.addSubview(disturbSwitch)
            disturbSwitch.centerYAnchor.constraint(equalTo: cell.centerYAnchor).isActive = true
            disturbSwitch.centerXAnchor.constraint(equalTo: cell.centerXAnchor, constant: (self.settingsTableview.frame.width/2)-50).isActive = true
            cell.detailTextLabel?.text = "Notification"
        }else if settings[indexPath.row] == "Notification" {
           cell.contentView.addSubview(notificationSwitch)
            notificationSwitch.centerYAnchor.constraint(equalTo: cell.centerYAnchor).isActive = true
            notificationSwitch.centerXAnchor.constraint(equalTo: cell.centerXAnchor, constant: (self.settingsTableview.frame.width/2)-50).isActive = true
            cell.detailTextLabel?.text = "Notification will not make Sound or vibrate"
        }else {
           cell.accessoryType = .disclosureIndicator
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView,heightForRowAt indexPath: IndexPath) -> CGFloat{
        return 60
    }
    
    @IBAction func categorySwitchValueChanged(_ sender : UISwitch!){
        
    }
    
}
