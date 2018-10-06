//
//  AVSettingsViewController.swift
//  AmericasVision
//
//  Created by Mohan Dola on 09/09/18.
//  Copyright © 2018 zeroGravity. All rights reserved.
//

import Foundation
import FirebaseDatabase


class AVSettingsViewController:UIViewController,UITableViewDataSource,UITableViewDelegate{
    
    @IBOutlet weak var homeButton: UIBarButtonItem!
    @IBOutlet weak var settingsTableview: UITableView!
    
    var settings = [AVInfo]()
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
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        sideMenus()
        loadGlobalInfo()
        self.navigationItem.title =  "User Preferences"
        settingsTableview.register(UITableViewCell.self, forCellReuseIdentifier: cellReuseIdentifier)
        settingsTableview.delegate = self
        settingsTableview.dataSource = self
        settingsTableview.tableFooterView = UIView()
        disturbSwitch.addTarget(self, action:#selector(AVSettingsViewController.categorySwitchValueChanged(_:)), for: .valueChanged)
        notificationSwitch.addTarget(self, action:#selector(AVSettingsViewController.categorySwitchValueChanged(_:)), for: .valueChanged)
        
    }
    
    func sideMenus(){
        if revealViewController() != nil {
            homeButton.target = revealViewController()
            homeButton.action = #selector(SWRevealViewController.revealToggle(_:))
            revealViewController().rearViewRevealWidth = 260
            view.addGestureRecognizer(self.revealViewController().panGestureRecognizer())
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        sideMenus()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return settings.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell =  UITableViewCell(style: UITableViewCellStyle.subtitle, reuseIdentifier: cellReuseIdentifier)
        
        if settings[indexPath.row].name == "Do not disturb" {
            cell.contentView.addSubview(disturbSwitch)
            disturbSwitch.centerYAnchor.constraint(equalTo: cell.centerYAnchor).isActive = true
            disturbSwitch.centerXAnchor.constraint(equalTo: cell.centerXAnchor, constant: (self.settingsTableview.frame.width/2)-50).isActive = true
            cell.textLabel?.text = settings[indexPath.row].name
            cell.detailTextLabel?.text = settings[indexPath.row].value
        }else if settings[indexPath.row].name == "Notification" {
           cell.contentView.addSubview(notificationSwitch)
            notificationSwitch.centerYAnchor.constraint(equalTo: cell.centerYAnchor).isActive = true
            notificationSwitch.centerXAnchor.constraint(equalTo: cell.centerXAnchor, constant: (self.settingsTableview.frame.width/2)-50).isActive = true
            cell.textLabel?.text = settings[indexPath.row].value
        }else if settings[indexPath.row].name == "Version" {
            cell.textLabel?.text = settings[indexPath.row].name
            cell.detailTextLabel?.text = settings[indexPath.row].value
        }else {
           cell.textLabel?.text = settings[indexPath.row].name
           cell.accessoryType = .disclosureIndicator
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView,heightForRowAt indexPath: IndexPath) -> CGFloat{
        return 60
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if settings[indexPath.row].name != "Do not disturb" && settings[indexPath.row].name != "Notification"
           && settings[indexPath.row].name != "Version"{
            let AVstoryboard = UIStoryboard(name: "AV", bundle: nil)
            let destinationViewController = AVstoryboard.instantiateViewController(withIdentifier: "SettingsDetailedViewController") as! SettingsDetailedViewController
            destinationViewController.name = settings[indexPath.row].name
            destinationViewController.displayText = settings[indexPath.row].value
            self.navigationController?.pushViewController(destinationViewController, animated: true)
        }
    }
    
    @IBAction func categorySwitchValueChanged(_ sender : UISwitch!){

    }
    
    func loadGlobalInfo(){
        let ref = DBProvider.instance.preferenceRef
        ref.observeSingleEvent(of : .value, with: {(snapshot: DataSnapshot) in
            var items = [AVInfo]()
            for item in snapshot.children{
                let child = item as! DataSnapshot
                let name = child.key as String
                let valueText = child.value as! String
                let info = AVInfo(name: name, value: valueText)
                items.append(info)
            }
            self.settings = items
            self.settingsTableview.reloadData()
        })
    }
    
}
