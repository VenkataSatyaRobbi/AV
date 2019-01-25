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
        self.layer.shadowColor = UIColor.black.cgColor
        self.layer.shadowOffset = CGSize(width: 0, height: 3.0)
        self.layer.shadowRadius = 3.0
        self.layer.shadowOpacity = 0.5
        self.layer.masksToBounds = false
        self.layer.shadowPath = UIBezierPath(roundedRect: self.bounds, cornerRadius: self.layer.cornerRadius).cgPath
    }
    
    func setAllignments(imageHeight:CGFloat,width:CGFloat,headHeight:CGFloat){
        imageView.heightAnchor.constraint(equalToConstant:imageHeight).isActive = true
        imageView.widthAnchor.constraint(equalToConstant:width).isActive = true
        headLines.topAnchor.constraint(equalTo: topAnchor, constant:imageHeight + 5).isActive = true
        headLines.widthAnchor.constraint(equalToConstant: width).isActive = true
        headLines.heightAnchor.constraint(equalToConstant: headHeight+5).isActive = true
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init code vote cell")
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
}

class NewsMatureViewController: UICollectionViewController,UICollectionViewDelegateFlowLayout {
    
    @IBOutlet weak var NewsFeedMatureHomeButton: UIBarButtonItem!
    let imageHeight:CGFloat = 100
    let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
    var posts = [Post]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = "Mature News"
        self.collectionView?.backgroundColor = UIColor.white
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
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "MatureCell", for: indexPath) as! MatureCell
        cell.headLines.text = posts[indexPath.item].postTitle
        let width:CGFloat = ((self.collectionView?.frame.width)! - 30)/2
        let titleHeight:CGFloat = CommonUtils.heightForView(text: posts[indexPath.item].postTitle, font:UIFont(name: "Verdana", size: 12)! ,width: width)
        cell.setAllignments(imageHeight:imageHeight,width: width,headHeight: titleHeight)
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
                    cell.imageView.image = imageData
                }
                
            }).resume()
            
        }
        
        return cell
    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let AVstoryboard = UIStoryboard(name: "AV", bundle: nil)
        let destinationViewController = AVstoryboard.instantiateViewController(withIdentifier: "NewsDetailedViewController") as! NewsDetailedViewController
        destinationViewController.postId = posts[indexPath.row].postID
        self.navigationController?.pushViewController(destinationViewController, animated: true)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
         let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "MatureCell", for: indexPath) as! MatureCell
        layout.sectionInset = UIEdgeInsets(top: 5, left: 10, bottom: 5, right: 10)
        let width:CGFloat = ((self.collectionView?.frame.width)! - 30)/2
        let titleHeight:CGFloat = CommonUtils.heightForView(text: posts[indexPath.item].postTitle, font:UIFont(name: "Verdana", size: 12)! ,width: width)
        cell.setAllignments(imageHeight:imageHeight,width: width, headHeight: titleHeight)
        return CGSize(width: width, height: imageHeight + titleHeight + 10)
    }
    
}
