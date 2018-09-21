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
    
    let settings = ["Do not disturb", "Privacy policy", "Terms of use","Rate & Feedback","Notification","Company Info","Version","Get Help"]
    let cellReuseIdentifier = "cell"
    
    
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
        self.navigationItem.title = "Contacts"
        settingsTableview.register(UITableViewCell.self, forCellReuseIdentifier: cellReuseIdentifier)
        
        settingsTableview.delegate = self as? UITableViewDelegate
        settingsTableview.dataSource = (self as! UITableViewDataSource)
        var top:CGFloat = 60
        for name in settings{
            
            let _explore: UIImageView = {
                let view = UIImageView()
                view.image = UIImage(named: "forward")
                view.translatesAutoresizingMaskIntoConstraints = false
                return view
            }()
            
            let _title: UILabel = {
                let label = UILabel()
                label.text = "Feedback"
                label.textColor = UIColor.black
                label.font = UIFont.systemFont(ofSize: 14)
                label.translatesAutoresizingMaskIntoConstraints = false
                label.textAlignment = .justified
                return label
            }()
            
            let _seperator: UIView = {
                let view = UIView()
                CommonUtils.addLineToView(view: view, position: .LINE_POSITION_BOTTOM, color: UIColor.lightGray, width: 1)
                view.translatesAutoresizingMaskIntoConstraints = false
                return view
            }()
            
            _title.text = name
            //           self.view.addSubview(_title)
            //           self.view.addSubview(_explore)
            //           self.view.addSubview(_seperator)
            //
            //            _title.topAnchor.constraint(equalTo: self.view.topAnchor, constant:top).isActive = true
            //            _title.heightAnchor.constraint(equalToConstant:59).isActive = true
            //            _title.widthAnchor.constraint(equalToConstant:self.view.frame.width - 40).isActive = true
            //            _title.leftAnchor.constraint(equalTo: self.view.leftAnchor, constant:10).isActive = true
            //
            //            _explore.topAnchor.constraint(equalTo: self.view.topAnchor, constant:top+5).isActive = true
            //            _explore.heightAnchor.constraint(equalToConstant:40).isActive = true
            //            _explore.widthAnchor.constraint(equalToConstant:40).isActive = true
            //            _explore.leftAnchor.constraint(equalTo: self.view.leftAnchor, constant:self.view.frame.width - 40).isActive = true
            //
            //            _seperator.topAnchor.constraint(equalTo: self.view.topAnchor, constant:top+59).isActive = true
            //            _seperator.leftAnchor.constraint(equalTo: self.view.leftAnchor, constant:1).isActive = true
            //            _seperator.heightAnchor.constraint(equalToConstant:1).isActive = true
            //            _seperator.widthAnchor.constraint(equalToConstant:self.view.frame.width).isActive = true
            //             top = top + 60
        }
    }
    
    func getSettingInfo(){
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return settings.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell:UITableViewCell = settingsTableview.dequeueReusableCell(withIdentifier: cellReuseIdentifier) as UITableViewCell!
        
        cell.textLabel?.text = settings[indexPath.row]
        cell.accessoryType = .disclosureIndicator
        
        return cell
    }
    
    func tableView(_ tableView: UITableView,heightForRowAt indexPath: IndexPath) -> CGFloat{
        return 60
    }
    
}
