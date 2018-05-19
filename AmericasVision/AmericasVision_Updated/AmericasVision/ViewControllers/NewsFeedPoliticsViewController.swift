//
//  NewsFeedPoliticsViewController.swift
//  AmericasVision
//
//  Created by Venkata Satya R Robbi on 5/5/18.
//  Copyright © 2018 zeroGravity. All rights reserved.
//

import UIKit
import FirebaseAuth
import FirebaseDatabase
import FirebaseStorage

class NewsFeedPoliticsViewController: UIViewController {

    @IBOutlet weak var NewsFeedPoliticsHomeButton: UIBarButtonItem!
    @IBOutlet weak var NewsFeedPoliticsCollectionView: UICollectionView!
    
    var posts = [Post]()
    
//    var selectedIndexPath: NSIndexPath! {
//        didSet{
//            self.NewsFeedPoliticsCollectionView.reloadData()
//        }
//    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        NewsFeedPoliticsCollectionView.isHidden = false
        NewsFeedPoliticsCollectionView.dataSource = self
        
        view.backgroundColor = UIColor.white
  
        sideMenus()
        loadPosts()
    }
    
//    override func viewWillAppear(_ animated: Bool) {
//        sideMenus()
//    }
    
    
    
//    var postID: String!
//    @IBAction func NewsFeedPoliticsLikeButton_Clicked(_ sender: Any) {
//        let AVPostRef = Database.database().reference().child("posts").childByAutoId()
//        print("post ref ID....\(AVPostRef)")
//        AVPostRef.child(self.postID).observeSingleEvent(of: .value) { (snapshot) in
//            if let likes = snapshot.value as? [String : AnyObject] {
//                // to do code here
//            }
//        }
//    }
//
//    @IBAction func NewsFeedPoliticsDislikeButton_Clicked(_ sender: Any) {
//    }
//
//    @IBAction func NewsFeedPoliticsCommentsButton_Clicked(_ sender: Any) {
//    }
    

    func loadPosts(){
        Database.database().reference().child("posts").queryOrdered(byChild: "category").queryEqual(toValue: "Category1").observe(.childAdded) { (snapshot: DataSnapshot) in
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
                //print("loading posts..")
                //print(self.posts)
                self.NewsFeedPoliticsCollectionView.reloadData()
            }
        }
    }
    
    func sideMenus(){
        if revealViewController() != nil {
            NewsFeedPoliticsHomeButton.target = revealViewController()
            NewsFeedPoliticsHomeButton.action = #selector(SWRevealViewController.revealToggle(_:))
            revealViewController().rearViewRevealWidth = 260
            view.addGestureRecognizer(self.revealViewController().panGestureRecognizer())
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

extension NewsFeedPoliticsViewController: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return posts.count
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: UIScreen.main.bounds.width, height: 230)
    }

    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 1.0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let item = NewsFeedPoliticsCollectionView.dequeueReusableCell(withReuseIdentifier: "PostCollectionViewCell", for: indexPath) as! PostCollectionViewCell
        
//        var borderColor: UIColor = UIColor.blue
//        var borderWidth: CGFloat = 0
        
//        if indexPath == selectedIndexPath as IndexPath{
//            borderColor = UIColor.brown
//            borderWidth = 1 //or whatever you please
//        }else{
//            borderColor = UIColor.clear
//            borderWidth = 0
//        }
        
//        item.layer.borderColor = UIColor(red: 48/255, green: 106/255, blue: 148/255, alpha: 1).cgColor
//        item.layer.borderWidth = 1
        
        item.PostCollectionViewCaption.isScrollEnabled = false
        item.PostCollectionViewHeadlines.isScrollEnabled = false
        item.PostCollectionViewCaption.text  = posts[indexPath.item].caption
        item.PostCollectionViewHeadlines.text = posts[indexPath.item].postTitle
//        item.PostCollectionViewLikes.text = "\(posts[indexPath.item].postLikes)"
//        item.PostCollectionViewDislikes.text = "\(posts[indexPath.item].postDislikes)"
//        item.PostCollectionViewComments.text = "\(posts[indexPath.item].postComments)"
        item.postID = self.posts[indexPath.item].postID
        //print("postid for the item...\(self.posts[indexPath.item].postID)")
        
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
                    item.PostCollectionViewImage.image = imageData
                }
                
            }).resume()
            
        }
        return item
    }
}

