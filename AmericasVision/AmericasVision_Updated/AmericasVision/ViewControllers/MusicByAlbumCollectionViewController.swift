//
//  MusicByAlbumCollectionViewController.swift
//  AmericasVision
//
//  Created by Mohan Dola on 26/08/18.
//  Copyright © 2018 zeroGravity. All rights reserved.
//

import Foundation


class MusicByAlbumCollectionViewController:UICollectionViewController,UICollectionViewDelegateFlowLayout{
    
    @IBOutlet weak var MusicByAlbumHomeButton: UIBarButtonItem!
    @IBOutlet weak var MusicByAlbumAdminButton: UIBarButtonItem!
    
    let numberOfSections = 2
    var albums = [MusicAlbum]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
       
        let backgroundView = UIView()
        let backgroundImage = UIImageView(frame: UIScreen.main.bounds)
        backgroundImage.image = UIImage(named: "musicback.jpg")
        backgroundImage.contentMode = UIViewContentMode.scaleAspectFill
        backgroundView.addSubview(backgroundImage)
        collectionView?.backgroundView = backgroundView
        
        collectionView!.register(MusicViewCell.self, forCellWithReuseIdentifier: "MusicViewCell")
        
        collectionView!.register(UICollectionViewCell.self, forSupplementaryViewOfKind: UICollectionElementKindSectionFooter, withReuseIdentifier: "MusicCellHeader")
        collectionView!.register(UICollectionViewCell.self, forSupplementaryViewOfKind: UICollectionElementKindSectionFooter, withReuseIdentifier: "MusicCellFooter")
        
        collectionView?.dataSource = self
        collectionView?.delegate = self
        sideMenus()
        loadAblums()
        self.navigationItem.title = "Music By Album"
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
        
        for i in 0 ... 8{
            let name = "etstee dkkd"
            let coverImageUrl = "https://firebasestorage.googleapis.com"
            let category = "Album"
            let albumId = "1212"
            let uploadedUserId = "121212"
            let uploadedDate = Date().timeIntervalSince1970
            let music = MusicAlbum(name: name, coverImageUrl: coverImageUrl, category: category, albumId: albumId, uploadedUserId: uploadedUserId, uploadedDate: uploadedDate)
            self.albums.append(music)
            self.collectionView?.reloadData()
        }
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        sideMenus()
    }
    
    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        return self.numberOfSections
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if section == 0 {
            return 4
        }else {
            return albums.count - 4
        }
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "MusicViewCell", for: indexPath) as! MusicViewCell
        cell.MusicTableImage.image = UIImage.init(named: "Unknown")
        cell.MusicTableHeadlines.text = "Rock ON"
        cell.MusicTableTilte.text = "Farhan Akhtar,Arujun Rampal,Prachi Desai"
        
        if indexPath.section == 0 {
            let imageWidth = ((self.collectionView?.frame.width)!/2)-10
            cell.setAllignments(imageSize:imageWidth,headLinesLeft:5,headLinesTop:imageWidth + 5,headLinesWidth:imageWidth-25,
                                tileTop:imageWidth + 20,titleLeft:5,menuTop:imageWidth + 5,menuLeft:imageWidth-25)
        }else  if indexPath.section == 1 {
            let imageWidth = ((self.collectionView?.frame.width)!)
            cell.setAllignments(imageSize:65,headLinesLeft:70,headLinesTop:5,headLinesWidth:imageWidth-70,
                                tileTop:25,titleLeft:70,menuTop:5,menuLeft:imageWidth-30)
        }
        
        return cell
    }
    
    override func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        
        if kind == UICollectionElementKindSectionHeader{
            
            let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "MusicCellHeader", for: indexPath)
            let label = UILabel()
            label.translatesAutoresizingMaskIntoConstraints = false
            label.text = "Jazz Music"
            label.textColor = UIColor.white
            header.addSubview(label)
            return header
        }else{
            let footer = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "MusicCellFooter", for: indexPath)
            let label = UILabel()
            label.translatesAutoresizingMaskIntoConstraints = false
            label.text = "See All"
            label.textColor = UIColor.white
            label.textAlignment = .right
            footer.addSubview(label)
            return footer
            
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width :CGFloat =  ((self.collectionView?.frame.width)!/2)-10
        let height:CGFloat = width+50
        if indexPath.section == 0{
            return CGSize(width: width, height: height)
        }else {
            return CGSize(width: (self.collectionView?.frame.width)!, height: 75)
        }
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        let height:CGFloat = 20
        return CGSize(width: (self.collectionView?.frame.width)!, height: height)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForFooterInSection section: Int) -> CGSize {
        let height:CGFloat = 20
        return CGSize(width: (self.collectionView?.frame.width)!, height: height)
    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let AVstoryboard = UIStoryboard(name: "AV", bundle: nil)
        let destinationViewController = AVstoryboard.instantiateViewController(withIdentifier: "AVMusicPlayerController") as! AVMusicPlayerController
        //destinationViewController.postId = albums[indexPath.row].albumId
        self.navigationController?.pushViewController(destinationViewController, animated: true)
    }
    
}

