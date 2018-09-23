//
//  MusicAlbumListController.swift
//  AmericasVision
//
//  Created by Mohan Dola on 23/09/18.
//  Copyright © 2018 zeroGravity. All rights reserved.
//

import Foundation

class MusicAlbumListController:UICollectionViewController,UICollectionViewDelegateFlowLayout{
    
    var tracks = [MusicTrack]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        collectionView?.backgroundColor = UIColor.groupTableViewBackground
        collectionView!.register(MusicAlbumTracksCell.self, forCellWithReuseIdentifier: "AlbumTracksViewCell")
        
        collectionView!.register(UICollectionViewCell.self, forSupplementaryViewOfKind: UICollectionElementKindSectionFooter, withReuseIdentifier: "AlbumListCellHeader")
        collectionView!.register(UICollectionViewCell.self, forSupplementaryViewOfKind: UICollectionElementKindSectionFooter, withReuseIdentifier: "AlbumListCellFooter")
        
        collectionView?.dataSource = self
        collectionView?.delegate = self
        sideMenus()
        loadAblumTracks()
        self.navigationItem.title = "Album Name"
    }
    
    func sideMenus(){
        
    }
    
    func loadAblumTracks(){
           for i in 0 ... 8{
            let trackId = "etstee dkkd"
            let coverImageUrl = "https://firebasestorage.googleapis.com"
            let category = "Album"
            let albumId = "1212"
            let trackUrl = "121212"
            let uploadedDate = Date().timeIntervalSince1970
            let track = MusicTrack(trackId: trackId, coverImageUrl: coverImageUrl, category: category, albumId: albumId, trackUrl: trackUrl, uploadedDate: uploadedDate)
            self.tracks.append(track)
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
        return 1
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return tracks.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "AlbumTracksViewCell", for: indexPath) as! MusicAlbumTracksCell
        cell.imageView.image = UIImage.init(named: "Unknown")
        cell.title.text = "Farhan Akhtar,Arujun Rampal,Prachi Desai"
        let width = ((self.collectionView?.frame.width)!)
        cell.setAllignments(imageSize: 70, tileTop: 200, menuTop: 200, menuLeft: width-40)
        return cell
    }
    
    override func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        
        if kind == UICollectionElementKindSectionHeader{
            
            let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "AlbumListCellHeader", for: indexPath)
            let view = UIImageView()
            view.translatesAutoresizingMaskIntoConstraints = false
            view.image = UIImage(named: "Unknoun")
            header.addSubview(view)
            return header
        }else{
            let footer = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "AlbumListCellFooter", for: indexPath)
            return footer
            
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: (self.collectionView?.frame.width)!, height: 70)
        
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return CGSize(width: (self.collectionView?.frame.width)!, height: 190)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForFooterInSection section: Int) -> CGSize {
        let height:CGFloat = 1
        return CGSize(width: (self.collectionView?.frame.width)!, height: height)
    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let AVstoryboard = UIStoryboard(name: "AV", bundle: nil)
        let destinationViewController = AVstoryboard.instantiateViewController(withIdentifier: "AVMusicPlayerController") as! AVMusicPlayerController
        //destinationViewController.postId = albums[indexPath.row].albumId
        self.navigationController?.pushViewController(destinationViewController, animated: true)
    }
    
}
