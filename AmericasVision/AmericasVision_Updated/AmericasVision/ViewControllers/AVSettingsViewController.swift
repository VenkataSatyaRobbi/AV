//
//  AVSettingsViewController.swift
//  AmericasVision
//
//  Created by Mohan Dola on 09/09/18.
//  Copyright © 2018 zeroGravity. All rights reserved.
//

import Foundation

class AVSettingsViewController:UIViewController{
    
    @IBOutlet weak var homeButton: UIBarButtonItem!
    
    let _explore: UIImageView = {
        let view = UIImageView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let _title: UILabel = {
        let label = UILabel()
        label.text = "Feedback"
        label.textColor = UIColor.black
        label.font = UIFont.systemFont(ofSize: 13)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .justified
        return label
    }()
    
    let _seperator: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
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
        var top:CGFloat = 40
        for i in 0 ... 8{
            
           self.view.addSubview(_title)
           self.view.addSubview(_explore)
           self.view.addSubview(_seperator)
           
            _title.topAnchor.constraint(equalTo: self.view.topAnchor, constant:top).isActive = true
            _title.heightAnchor.constraint(equalToConstant:29).isActive = true
            _title.widthAnchor.constraint(equalToConstant:self.view.frame.width - 30).isActive = true
            
            _explore.topAnchor.constraint(equalTo: self.view.topAnchor, constant:top).isActive = true
            _explore.heightAnchor.constraint(equalToConstant:29).isActive = true
            _explore.widthAnchor.constraint(equalToConstant:30).isActive = true
            _explore.leftAnchor.constraint(equalTo: self.view.leftAnchor, constant:self.view.frame.width - 30).isActive = true
            
            _seperator.topAnchor.constraint(equalTo: self.view.topAnchor, constant:top+29).isActive = true
            _seperator.leftAnchor.constraint(equalTo: self.view.leftAnchor, constant:1).isActive = true
            _seperator.heightAnchor.constraint(equalToConstant:1).isActive = true
            _seperator.widthAnchor.constraint(equalToConstant:self.view.frame.width).isActive = true
             top = top + 30
        }
    }
    
}
