//
//  NewsFeedMatureCollectionViewController.swift
//  AmericasVision
//
//  Created by Venkata Satya R Robbi on 7/22/18.
//  Copyright © 2018 zeroGravity. All rights reserved.
//

import UIKit
import FirebaseAuth
import FirebaseDatabase
import FirebaseStorage

private let reuseIdentifier = "PostCollectionViewCell"

class NewsFeedMatureCollectionViewController: UICollectionViewController {
    @IBOutlet weak var  NewsFeedMatureHomeButton: UIBarButtonItem!
    
    
    var posts = [Post]()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false
        collectionView?.dataSource = self
        collectionView?.delegate = self

        // Register cell classes
        //self.collectionView!.register(UICollectionViewCell.self, forCellWithReuseIdentifier: reuseIdentifier)

        // Do any additional setup after loading the view.
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
                print("loading posts..")
                print(self.posts)
                self.collectionView?.reloadData()
            }
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
        // Get the new view controller using [segue destinationViewController].
        // Pass the selected object to the new view controller.
    }
    */

    // MARK: UICollectionViewDataSource

//    override func numberOfSections(in collectionView: UICollectionView) -> Int {
//        // #warning Incomplete implementation, return the number of sections
//        return 1
//    }


    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of items
        print(posts.count)
        return posts.count
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
            let item = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! PostCollectionViewCell
        
        item.PostCollectionViewHeadlines.text = posts[indexPath.item].postTitle
        item.PostCollectionViewHeadlines.isScrollEnabled = false
        print(posts[indexPath.item].postTitle)
            
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
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let itemSize = (collectionView.frame.width - (collectionView.contentInset.left + collectionView.contentInset.right + 10)) / 2
        return CGSize(width: itemSize, height: itemSize)
    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let AVstoryboard = UIStoryboard(name: "AV", bundle: nil)
        let destinationViewController = AVstoryboard.instantiateViewController(withIdentifier: "NewsDetailedViewController") as! NewsDetailedViewController
        
        destinationViewController.getPhotoCourtesy = posts[indexPath.row].imageCourtesy
        destinationViewController.getContent = posts[indexPath.row].newsContent
        let postDate = CommonUtils.convertFromTimestamp(seconds: posts[indexPath.row].timestamp)
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MM-dd-yyyy"
        let postDateDate = dateFormatter.date(from: postDate)
        
        let dateFormatter2 = DateFormatter()
        dateFormatter2.dateFormat = "EEEE, MMM dd, yyyy. HH':'mm"
        let currentDateString: String = dateFormatter2.string(from: postDateDate!)
        print("Current date is \(currentDateString)")
        destinationViewController.getLocationandTimestamp = posts[indexPath.row].newsLocation + " - " + currentDateString

        destinationViewController.likes = posts[indexPath.row].postLikes
        destinationViewController.dislikes = posts[indexPath.row].postDislikes
        destinationViewController.postId = posts[indexPath.row].postID
        destinationViewController.getPhotoURL = posts[indexPath.row].photoUrl
        destinationViewController.getPostedBy = posts[indexPath.row].userid
        self.navigationController?.pushViewController(destinationViewController, animated: true)
        
        let rowDataPostID = posts[indexPath.row].postID
        print("rowdata ID value: \(rowDataPostID)")
    }
}
    // MARK: UICollectionViewDelegate

    /*
    // Uncomment this method to specify if the specified item should be highlighted during tracking
    override func collectionView(_ collectionView: UICollectionView, shouldHighlightItemAt indexPath: IndexPath) -> Bool {
        return true
    }
    */

    /*
    // Uncomment this method to specify if the specified item should be selected
    override func collectionView(_ collectionView: UICollectionView, shouldSelectItemAt indexPath: IndexPath) -> Bool {
        return true
    }
    */

    /*
    // Uncomment these methods to specify if an action menu should be displayed for the specified item, and react to actions performed on the item
    override func collectionView(_ collectionView: UICollectionView, shouldShowMenuForItemAt indexPath: IndexPath) -> Bool {
        return false
    }

    override func collectionView(_ collectionView: UICollectionView, canPerformAction action: Selector, forItemAt indexPath: IndexPath, withSender sender: Any?) -> Bool {
        return false
    }

    override func collectionView(_ collectionView: UICollectionView, performAction action: Selector, forItemAt indexPath: IndexPath, withSender sender: Any?) {
    
    }
    */
