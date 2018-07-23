//
//  VotesCollectionViewController.swift
//  AmericasVision
//
//  Created by Venkata Satya R Robbi on 5/5/18.
//  Copyright © 2018 zeroGravity. All rights reserved.
//

import UIKit

private let reuseIdentifier = "voteCell"

class VotesCollectionViewController: UICollectionViewController {

    @IBOutlet weak var VotesHomeButton: UIBarButtonItem!
    private let count = 2
    
    let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
    
    var collectionData = ["23","24"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
     
      // let flagImageView = UIImageView(frame:  CGRect(x:10, y: -30, width: 395 , height: 300
      // ))
       
        
        layout.sectionInset = UIEdgeInsets(top: 20, left: 10, bottom: 10, right: 10)
        let cellwidth = Int(self.view.frame.width - 30)/count
        let cellHeight = Int(self.view.frame.height - 380)/count
        layout.itemSize = CGSize(width: cellwidth, height: cellHeight)
       
        self.collectionView?.collectionViewLayout = layout
       //  Register cell classes
        self.collectionView!.register(UICollectionViewCell.self, forCellWithReuseIdentifier: reuseIdentifier)

        sideMenus()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        sideMenus()
    }

    func sideMenus(){
        if revealViewController() != nil {
            VotesHomeButton.target = revealViewController()
            VotesHomeButton.action = #selector(SWRevealViewController.revealToggle(_:))
            revealViewController().rearViewRevealWidth = 260
            view.addGestureRecognizer(self.revealViewController().panGestureRecognizer())
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    override func numberOfSections(in collectionView: UICollectionView) -> Int {
       return 1
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath)
        cell.backgroundColor = UIColor.black
      /*
         
         let bgImage = UIImageView();
         bgImage.image = UIImage(named: "flag");
         bgImage.contentMode = .scaleToFill
         self.collectionView?.backgroundView = bgImage
         
         */
        self.collectionView?.backgroundColor = UIColor.groupTableViewBackground
       

        let imgView = UIImageView(frame:  CGRect(x: 0, y: 0, width: layout.itemSize.width , height: layout.itemSize.height))
        imgView.contentMode = .scaleAspectFit
        imgView.image = UIImage(named: "image.jpg")
        imgView.clipsToBounds = true
        
        var dynamicLabel: UILabel = UILabel()
        dynamicLabel = UILabel(frame:  CGRect(x:3, y:2, width:185, height:35))
        //dynamicLabel.backgroundColor = UIColor.white
        dynamicLabel.textColor = UIColor.white
         dynamicLabel.layer.cornerRadius = 10
        dynamicLabel.textAlignment = NSTextAlignment.center
        dynamicLabel.text = "Democrat Party "
        imgView.addSubview(dynamicLabel)
        
        
        var dynamicLabel1: UILabel = UILabel()
        dynamicLabel1 = UILabel(frame:  CGRect(x:4, y:140, width:190, height:35))
        //dynamicLabel1.backgroundColor = UIColor.white
        dynamicLabel1.textColor = UIColor.white
        dynamicLabel1.layer.cornerRadius = 10
        dynamicLabel1.textAlignment = NSTextAlignment.center
        dynamicLabel1.text = "Candidate name "
        
        imgView.addSubview(dynamicLabel1)
        
        let imgView1 = UIImageView(frame:  CGRect(x: 0, y:38, width: 100, height:100))
        imgView1.contentMode = .scaleAspectFit
        imgView1.layer.cornerRadius = 50.0
        imgView1.clipsToBounds = true
        imgView1.image = UIImage(named: "profile")
        imgView.addSubview(imgView1)
        
        cell.layer.cornerRadius = 10
        cell.contentView.addSubview(imgView)
        
        
    
       
        return cell
    }
    
}
