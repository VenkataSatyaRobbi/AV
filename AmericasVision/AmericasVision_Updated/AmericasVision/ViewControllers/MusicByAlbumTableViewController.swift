//
//  MusicByAlbumTableViewController.swift
//  AmericasVision
//
//  Created by Venkata Satya R Robbi on 5/5/18.
//  Copyright © 2018 zeroGravity. All rights reserved.
//

import UIKit

class MusicByAlbumTableViewController: UITableViewController {

    
    @IBOutlet weak var MusicByAlbumHomeButton: UIBarButtonItem!
    @IBOutlet weak var MusicByAlbumAdminButton: UIBarButtonItem!
    
  
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
        
   
        
       
        
       
        sideMenus()
    }
    
    
   
    
    func sideMenus(){
        
        if revealViewController() != nil {
            MusicByAlbumHomeButton.target = revealViewController()
            MusicByAlbumHomeButton.action = #selector(SWRevealViewController.revealToggle(_:))
            revealViewController().rearViewRevealWidth = 260
            view.addGestureRecognizer(self.revealViewController().panGestureRecognizer())
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        sideMenus()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

 /*   override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 3
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return 1
    }
    */
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    
    override func tableView(_ tableView: UITableView,heightForRowAt indexPath: IndexPath) -> CGFloat{
        return 223
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let row = indexPath.row
        
        
        if row == 0 {
             let cell = tableView.dequeueReusableCell(withIdentifier: "MusicTableViewCell", for: indexPath) as! MusicTableViewCell
            
            return cell
        }else{
        let cell = tableView.dequeueReusableCell(withIdentifier: "MusicTableViewCell1", for: indexPath) as! MusicTableViewCell
         
        return cell
        }
    }
    
}

