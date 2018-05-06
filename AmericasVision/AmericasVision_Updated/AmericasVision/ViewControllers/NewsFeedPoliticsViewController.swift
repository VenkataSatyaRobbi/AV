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
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        NewsFeedPoliticsCollectionView.isHidden = false
        NewsFeedPoliticsCollectionView.dataSource = self
        
        view.backgroundColor = UIColor.white
        
        sideMenus()
        loadPosts()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        sideMenus()
    }
    
    
    let AVPostRef = Database.database().reference().child("posts")
    var postID: String!
    @IBAction func NewsFeedPoliticsLikeButton_Clicked(_ sender: Any) {
        AVPostRef.child(self.postID).observeSingleEvent(of: .value) { (snapshot) in
            if let likes = snapshot.value as? [String : AnyObject] {
                // to do code here
            }
        }
        
    }
    
    @IBAction func NewsFeedPoliticsDislikeButton_Clicked(_ sender: Any) {
    }
    
    @IBAction func NewsFeedPoliticsCommentsButton_Clicked(_ sender: Any) {
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
                let post = Post(captionText: captionText, photoUrlString: photoUrlString, postCategoryString: postCategoryString, postTitleString: postTitleString, postLikesInt: postLikesInt, postDislikesInt: postDislikesInt, postCommentsInt: postCommentsInt)
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
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}

extension NewsFeedPoliticsViewController: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return posts.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let item = NewsFeedPoliticsCollectionView.dequeueReusableCell(withReuseIdentifier: "PostCollectionViewCell", for: indexPath) as! PostCollectionViewCell
        item.PostCollectionViewContent.isScrollEnabled = false;//
        item.PostCollectionViewContent.text  = posts[indexPath.item].caption
        item.PostCollectionViewHeadlines.text = posts[indexPath.item].postTitle
        item.PostCollectionViewLikes.text = "\(posts[indexPath.item].postLikes)"
        item.PostCollectionViewDislikes.text = "\(posts[indexPath.item].postDislikes)"
        item.PostCollectionViewComments.text = "\(posts[indexPath.item].postComments)"
        
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

