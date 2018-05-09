//
//  VotingViewController.swift
//  AmericasVision
//
//  Created by Venkata Satya R Robbi on 4/1/18.
//  Copyright © 2018 zeroGravity. All rights reserved.
//

import UIKit
import FirebaseAuth

class VotingViewController: UIViewController {
    
    @IBOutlet weak var ProfileButton: UIBarButtonItem!
    
    @IBOutlet weak var CandidateViewSecondParty: UIImageView!
    @IBOutlet weak var CandidateViewFirstParty: UIImageView!
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.white
        
        CandidateViewSecondParty.layer.cornerRadius = CandidateViewSecondParty.frame.height/2
        CandidateViewSecondParty.clipsToBounds = true
        
        CandidateViewFirstParty.layer.cornerRadius = CandidateViewFirstParty.frame.height/2
        CandidateViewFirstParty.clipsToBounds = true
        
        sideMenus()
        
        // Do any additional setup after loading the view.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func sideMenus(){
        
        if revealViewController() != nil {
            ProfileButton.target = revealViewController()
            ProfileButton.action = #selector(SWRevealViewController.revealToggle(_:))
            revealViewController().rearViewRevealWidth = 260
            view.addGestureRecognizer(self.revealViewController().panGestureRecognizer())
        }
    }
    
}
