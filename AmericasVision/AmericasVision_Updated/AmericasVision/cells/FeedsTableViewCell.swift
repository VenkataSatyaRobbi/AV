//
//  FeedsTableViewCell.swift
//  AmericasVision
//
//  Created by Mohan Dola on 20/05/18.
//  Copyright © 2018 zeroGravity. All rights reserved.
//

import UIKit

class FeedsTableViewCell: UITableViewCell {
    
//    let latestUpdates: UILabel = {
//        let label = UILabel()
//        label.textColor = UIColor.black
//        label.font = UIFont.systemFont(ofSize: 14)
//        label.translatesAutoresizingMaskIntoConstraints = false
//        label.numberOfLines = 0
//        label.sizeToFit()
//        label.textAlignment = .justified
//        return label
//    }()
//
//    @IBOutlet weak var collectionView: UICollectionView!
//
//    required init?(coder aDecoder: NSCoder) {
//        fatalError("init(coder:) has not been implemented")
//    }
//
//    override func awakeFromNib() {
//        super.awakeFromNib()
//
//    }
//
//    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
//        super.init(style: style, reuseIdentifier: reuseIdentifier)
//        self.contentView.layer.borderColor = UIColor.groupTableViewBackground.cgColor
//        self.contentView.backgroundColor = UIColor.white
//        let width = self.contentView.layer.frame.width - 30
//        self.addSubview(latestUpdates)
//
//        latestUpdates.leftAnchor.constraint(equalTo: leftAnchor, constant:20).isActive = true
//        latestUpdates.topAnchor.constraint(equalTo: topAnchor, constant:20).isActive = true
//        latestUpdates.widthAnchor.constraint(equalToConstant: (width/3)).isActive = true
//    }
//
//    override func setSelected(_ selected: Bool, animated: Bool) {
//        super.setSelected(selected, animated: animated)
//    }
//
//    func registerCollectoinView<DataSource:UICollectionViewDataSource>(datasource:DataSource){
//
//        self.collectionView.dataSource = datasource
//    }
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    func registerCollectoinView<DataSource:UICollectionViewDataSource>(datasource:DataSource){
        self.collectionView.dataSource = datasource
    }
    
}
