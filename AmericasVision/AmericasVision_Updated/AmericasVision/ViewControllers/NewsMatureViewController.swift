//
//  NewsMatureViewController.swift
//  AmericasVision
//
//  Created by Mohan Dola on 13/08/18.
//  Copyright © 2018 zeroGravity. All rights reserved.
//

import Foundation
import FirebaseAuth
import FirebaseDatabase
import FirebaseStorage

class MatureCell: UICollectionViewCell{
    
    var Id:String = ""
    
    var imageView : UIImageView = {
        let view = UIImageView()
        view.translatesAutoresizingMaskIntoConstraints = false
        let image = UIImage(named: "default")
        view.image = image
        return view
    }()
    
    let headLines: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        label.sizeToFit()
        label.font = UIFont(name: "Verdana", size: 12)
        label.textAlignment = .justified
        label.lineBreakMode = .byWordWrapping
        label.backgroundColor = UIColor.white
        return label
    }()
    
    override init(frame: CGRect) {
        
        super.init(frame: frame)
        backgroundColor = UIColor.white
        self.addSubview(imageView)
        self.addSubview(headLines)
        let width = (self.contentView.frame.width)
 
        imageView.heightAnchor.constraint(equalToConstant:100).isActive = true
        imageView.widthAnchor.constraint(equalToConstant:width).isActive = true

        headLines.topAnchor.constraint(equalTo: topAnchor, constant:100).isActive = true
        headLines.widthAnchor.constraint(equalToConstant: width).isActive = true
        
        self.layer.shadowColor = UIColor.black.cgColor
        self.layer.shadowOffset = CGSize(width: 0, height: 3.0)
        self.layer.shadowRadius = 3.0
        self.layer.shadowOpacity = 0.5
        self.layer.masksToBounds = false
        self.layer.shadowPath = UIBezierPath(roundedRect: self.bounds, cornerRadius: self.layer.cornerRadius).cgPath
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init code vote cell")
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
}

class NewsMatureViewController: UICollectionViewController {
    
    @IBOutlet weak var NewsFeedMatureHomeButton: UIBarButtonItem!
    
    let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
    var cellwidth :CGFloat = 0
    var cellHeight :CGFloat = 130
    var posts = [Post]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = "Mature News"
        self.collectionView?.backgroundColor = UIColor.white
        
        layout.sectionInset = UIEdgeInsets(top: 5, left: 10, bottom: 5, right: 10)
        cellwidth = (self.view.frame.width-30)/2

        layout.itemSize = CGSize(width: cellwidth, height: cellHeight)

        self.collectionView?.collectionViewLayout = layout
        collectionView!.register(MatureCell.self, forCellWithReuseIdentifier: "MatureCell")
        collectionView?.dataSource = self
        collectionView?.delegate = self
        sideMenus()
        loadPosts()
    }
    
    func sideMenus(){
        if revealViewController() != nil {
            NewsFeedMatureHomeButton.target = revealViewController()
            NewsFeedMatureHomeButton.action = #selector(SWRevealViewController.revealToggle(_:))
            revealViewController().rearViewRevealWidth = 260
            view.addGestureRecognizer(self.revealViewController().panGestureRecognizer())
        }
    }
    
    func loadPosts(){
        Database.database().reference().child("posts").queryOrdered(byChild: "category").queryEqual(toValue: "Mature").observe(.childAdded) { (snapshot: DataSnapshot) in
            //print(snapshot.value)
            if let dict = snapshot.value as? [String: Any] {
                let captionText = dict["caption"] as! String
                let photoUrlString = dict["photoUrl"] as! String
                let postCategoryString = dict["category"] as! String
                let postTitleString = dict["title"] as! String
                let postLikesInt = dict["likes"] as! NSNumber
                let postDislikesInt = dict["dislikes"] as! NSNumber
                let postCommentsInt = dict["comments"] as! NSNumber
                let postIDString = dict["postID"] as! String
                let useridString = dict["userid"] as! String
                let timestamp = dict["timestamp"] as! Double
                let photoCourtesyString = dict["photoCourtesy"] as! String
                let newsContentString = dict["newsContent"] as! String
                let newsLocationString = dict["newsLocation"] as! String
                let post = Post(captionText: captionText, photoUrlString: photoUrlString, postCategoryString: postCategoryString, postTitleString: postTitleString, postLikesInt: postLikesInt, postDislikesInt: postDislikesInt, postCommentsInt: postCommentsInt,postIDString: postIDString, useridString: useridString, timeStampDouble: timestamp, imageCourtesyString: photoCourtesyString, newsLocationString: newsLocationString, newsContentString: newsContentString)
                self.posts.append(post)
                self.collectionView?.reloadData()
            }
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    override func viewWillAppear(_ animated: Bool) {
        sideMenus()
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return posts.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let item = collectionView.dequeueReusableCell(withReuseIdentifier: "MatureCell", for: indexPath) as! MatureCell
        item.headLines.text = posts[indexPath.item].postTitle
        
        let AVPostStorageRef = Storage.storage().reference(forURL: posts[indexPath.item].photoUrl)
        AVPostStorageRef.downloadURL { (url, error) in
            if error != nil{
                print(error?.localizedDescription as Any)
                return
            }
            URLSession.shared.dataTask(with: url!, completionHandler: { (data, response, error) in
                if error != nil {
                    print(error?.localizedDescription as Any)
                    return
                }
                
                guard let imageData = UIImage(data: data!) else { return }
                DispatchQueue.main.async {
                    print(imageData)
                    item.imageView.image = imageData
                }
                
            }).resume()
            
        }
        return item
    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let AVstoryboard = UIStoryboard(name: "AV", bundle: nil)
        let destinationViewController = AVstoryboard.instantiateViewController(withIdentifier: "NewsDetailedViewController") as! NewsDetailedViewController
        destinationViewController.postId = posts[indexPath.row].postID
        self.navigationController?.pushViewController(destinationViewController, animated: true)
        let rowDataPostID = posts[indexPath.row].postID
        print("rowdata ID value: \(rowDataPostID)")
    }
    
}
