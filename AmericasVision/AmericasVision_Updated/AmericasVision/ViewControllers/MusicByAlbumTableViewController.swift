//
//  MusicByAlbumTableViewController.swift
//  AmericasVision
//
//  Created by Venkata Satya R Robbi on 5/5/18.
//  Copyright © 2018 zeroGravity. All rights reserved.
//

import UIKit
import FirebaseAuth
import FirebaseDatabase
import FirebaseStorage

class MusicByAlbumTableViewController: UITableViewController {
    
    @IBOutlet weak var MusicByAlbumHomeButton: UIBarButtonItem!
    @IBOutlet weak var MusicByAlbumAdminButton: UIBarButtonItem!
    
    var albums = [MusicAlbum]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.lightGray
        tableView.register(MusicTableViewCell.self, forCellReuseIdentifier: "MusicTableViewCell")
        sideMenus()
        loadAblums()
        self.navigationItem.title = "Music By Album"
//        let backgroundImage = UIImageView(frame: UIScreen.main.bounds)
//        backgroundImage.image = UIImage(named: "musicback.jpg")
//        backgroundImage.contentMode = UIViewContentMode.scaleAspectFill
//        self.tableView.insertSubview(backgroundImage, at: 0)
    }
    
    func sideMenus(){
        if revealViewController() != nil {
            MusicByAlbumHomeButton.target = revealViewController()
            MusicByAlbumHomeButton.action = #selector(SWRevealViewController.revealToggle(_:))
            revealViewController().rearViewRevealWidth = 260
            view.addGestureRecognizer(self.revealViewController().panGestureRecognizer())
        }
    }
    
    func loadAblums(){
        /*Database.database().reference().child("Music").queryOrdered(byChild: "category").queryEqual(toValue: "Sports").observe(.childAdded) { (snapshot: DataSnapshot) in
            if let dict = snapshot.value as? [String: Any] {
                let name = dict["caption"] as! String
                let coverImageUrl = dict["photoUrl"] as! String
                let category = dict["category"] as! String
                let albumId = dict["title"] as! String
                let uploadedUserId = dict["title"] as! String
                let uploadedDate = dict["likes"] as! Double
                let music = MusicAlbum(name: name, coverImageUrl: coverImageUrl, category: category, albumId: albumId, uploadedUserId: uploadedUserId, uploadedDate: uploadedDate)
                self.albums.append(music)
                self.tableView.reloadData()
               
            }
        }*/
        
        for i in 0 ... 4{
            let name = "etstee dkkd"
            let coverImageUrl = "https://firebasestorage.googleapis.com"
            let category = "Album"
            let albumId = "1212"
            let uploadedUserId = "121212"
            let uploadedDate = Date().timeIntervalSince1970
            let music = MusicAlbum(name: name, coverImageUrl: coverImageUrl, category: category, albumId: albumId, uploadedUserId: uploadedUserId, uploadedDate: uploadedDate)
            self.albums.append(music)
             self.tableView.reloadData()
        }
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        sideMenus()
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return albums.count
    }
    
    override func tableView(_ tableView: UITableView,heightForRowAt indexPath: IndexPath) -> CGFloat{
        return 70
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "MusicTableViewCell") as! MusicTableViewCell
        cell.MusicTableImage.image = UIImage.init(named: "Unknown")
        cell.MusicTableHeadlines.text = "Rock ON"
        cell.MusicTableTilte.text = "Farhan Akhtar,Arujun Rampal,Prachi Desai"
        return cell
        
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let AVstoryboard = UIStoryboard(name: "AV", bundle: nil)
        let destinationViewController = AVstoryboard.instantiateViewController(withIdentifier: "AVMusicPlayerController") as! AVMusicPlayerController
        //destinationViewController.postId = albums[indexPath.row].albumId
        self.navigationController?.pushViewController(destinationViewController, animated: true)
        
    }

}
