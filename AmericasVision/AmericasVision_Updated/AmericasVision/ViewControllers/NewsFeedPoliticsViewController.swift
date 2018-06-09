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
     @IBOutlet weak var politicsTableView: UITableView!
    
    var posts = [Post]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        politicsTableView.isHidden = false
        politicsTableView.dataSource = self
        politicsTableView.delegate = self
        //view.backgroundColor = UIColor.white
        sideMenus()
        loadPosts()
    }
    
    func sideMenus(){
        if revealViewController() != nil {
            NewsFeedPoliticsHomeButton.target = revealViewController()
            NewsFeedPoliticsHomeButton.action = #selector(SWRevealViewController.revealToggle(_:))
            revealViewController().rearViewRevealWidth = 260
            view.addGestureRecognizer(self.revealViewController().panGestureRecognizer())
        }
    }
  
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
                self.politicsTableView.reloadData()
            }
        }
    }
   
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    /*
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
     
     */
    
}

extension NewsFeedPoliticsViewController:UITableViewDataSource,UITableViewDelegate{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return posts.count
    }
    
    func tableView(_ tableView: UITableView,heightForRowAt indexPath: IndexPath) -> CGFloat{
            return 200
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let newsRow = tableView.dequeueReusableCell(withIdentifier: "PostTableViewCell", for: indexPath) as! PostTableViewCell
      
            newsRow.PostTableViewHeadlines.text = posts[indexPath.row].postTitle
            newsRow.PostCollectionViewCaption.text = posts[indexPath.row].caption
            newsRow.PostTableViewHeadlines.isScrollEnabled = false
            newsRow.PostCollectionViewCaption.isScrollEnabled = false
            newsRow.postID = self.posts[indexPath.row].postID
        
     
        
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
                        newsRow.PostTableViewImage.image = imageData
                    }
                }).resume()
            }
            return newsRow
        }        
}
