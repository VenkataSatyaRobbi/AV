//
//  NewsTableViewCell.swift
//  AmericasVision
//
//  Created by Mohan Dola on 12/08/18.
//  Copyright © 2018 zeroGravity. All rights reserved.
//

import Foundation

class NewsTableViewCell: UITableViewCell,UICollectionViewDelegate {
    
    @IBOutlet var collectionView: UICollectionView!
    @IBOutlet weak var cellImage: UIImageView!
    @IBOutlet weak var headlines: UILabel!
    
    var Id:String = ""
    
   var imageView1 : UIImageView = {
        let view = UIImageView()
        view.translatesAutoresizingMaskIntoConstraints = false
        let image = UIImage(named: "default")
        view.image = image
        view.layer.cornerRadius = 5
        view.clipsToBounds = true
        return view
    }()
    
    let headLines: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        label.sizeToFit()
        label.font = UIFont.boldSystemFont(ofSize: 14)
        label.textAlignment = .justified
        return label
    }()
    
    let caption: UILabel = {
        let label = UILabel()
        label.textColor = UIColor.black
        label.font = UIFont.systemFont(ofSize: 14)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        label.sizeToFit()
        label.textAlignment = .justified
        return label
    }()
   
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        cellImage.layer.cornerRadius = 5.0
        cellImage.clipsToBounds = true
        
        headlines.layer.cornerRadius = 5.0
        headlines.clipsToBounds = true
        
        self.collectionView!.backgroundColor = UIColor.clear
        self.collectionView.delegate = self as? UICollectionViewDelegate
        self.collectionView.dataSource = self as? UICollectionViewDataSource
       
        collectionView.reloadData()
       
    }
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
       
        self.contentView.layer.borderColor = UIColor.groupTableViewBackground.cgColor
        self.contentView.layer.borderWidth = 2.0
        self.contentView.layer.cornerRadius = 5.0
        self.contentView.layer.masksToBounds = false
        self.contentView.backgroundColor = UIColor.white
        let width = self.contentView.layer.frame.width - 30
        self.addSubview(imageView1)
        self.addSubview(headLines)
        self.addSubview(caption)
        
        imageView1.leftAnchor.constraint(equalTo: leftAnchor, constant:15).isActive = true
        imageView1.topAnchor.constraint(equalTo: topAnchor, constant:15).isActive = true
        imageView1.heightAnchor.constraint(equalToConstant:90).isActive = true
        imageView1.widthAnchor.constraint(equalToConstant:width/3).isActive = true
        // 10 = 5 left image + 5
        headLines.leftAnchor.constraint(equalTo: leftAnchor, constant:(width/3) + 20).isActive = true
        headLines.rightAnchor.constraint(equalTo: rightAnchor, constant:-15).isActive = true
        headLines.topAnchor.constraint(equalTo: topAnchor, constant:15).isActive = true
        headLines.widthAnchor.constraint(equalToConstant: width-(width/3)).isActive = true
        
        caption.leftAnchor.constraint(equalTo: leftAnchor, constant: 15).isActive = true
        caption.rightAnchor.constraint(equalTo: rightAnchor, constant:-15).isActive = true
        // topanchor + imageheight
        caption.topAnchor.constraint(equalTo: topAnchor, constant:110).isActive = true
        caption.widthAnchor.constraint(equalToConstant: width).isActive = true
        caption.bottomAnchor.constraint(equalTo: bottomAnchor,constant:-5).isActive = true
        
    }
    
//    func setCollectionViewDataSourceDelegate
//        <D: UICollectionViewDataSource & UICollectionViewDelegate>
//        (dataSourceDelegate: D, forRow row: Int) {
//
//
//        self.collectionView!.backgroundColor = UIColor.clear
//        self.collectionView.delegate = self as? UICollectionViewDelegate
//        self.collectionView.dataSource = self as? UICollectionViewDataSource
//        collectionView.tag = row
//        collectionView.reloadData()
//    }
    
//    func setCollectionViewDataSourceDelegate<D: UICollectionViewDataSource & UICollectionViewDelegate>(_ dataSourceDelegate: D, forRow row: Int) {
//
//        collectionView.delegate = dataSourceDelegate
//        collectionView.dataSource = dataSourceDelegate
//        collectionView.tag = row
//        collectionView.setContentOffset(collectionView.contentOffset, animated:false) // Stops collection view if it was scrolling.
//        collectionView.reloadData()
//    }
    
//    func registerCollectoinView<DataSource:UICollectionViewDataSource>(datasource:DataSource){
//
//        self.collectionView.dataSource = datasource
//    }
}
