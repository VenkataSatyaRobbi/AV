//
//  NewsMiscellaneousViewcontroller.swift
//  AmericasVision
//
//  Created by Mohan Dola on 13/08/18.
//  Copyright © 2018 zeroGravity. All rights reserved.
//

import Foundation
import UIKit
import FirebaseAuth
import FirebaseDatabase
import FirebaseStorage

class NewsMiscellaneousViewController: UITableViewController{
    
    @IBOutlet weak var NewsFeedMiscHomeButton: UIBarButtonItem!
    
    var posts = [Post]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.register(NewsTableViewCell.self, forCellReuseIdentifier: "NewsTableViewCell")
        tableView?.dataSource = self
        tableView?.delegate = self
        self.tableView.backgroundColor = UIColor.groupTableViewBackground
        sideMenus()
        loadPosts()
    }
    
    func sideMenus(){
        if revealViewController() != nil {
            NewsFeedMiscHomeButton.target = revealViewController()
            NewsFeedMiscHomeButton.action = #selector(SWRevealViewController.revealToggle(_:))
            revealViewController().rearViewRevealWidth = 260
            view.addGestureRecognizer(self.revealViewController().panGestureRecognizer())
        }
    }
    
    func loadPosts(){
        Database.database().reference().child("posts").queryOrdered(byChild: "category").queryEqual(toValue: "Misc").observe(.childAdded) { (snapshot: DataSnapshot) in
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
                self.tableView.reloadData()
            }
        }
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return posts.count
    }
    
    override func tableView(_ tableView: UITableView,heightForRowAt indexPath: IndexPath) -> CGFloat{
        return 115
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let newsRow = tableView.dequeueReusableCell(withIdentifier: "NewsTableViewCell", for: indexPath) as! NewsTableViewCell
        //newsRow.accessoryType = UITableViewCellAccessoryType.disclosureIndicator
        newsRow.headLines.text = posts[indexPath.row].postTitle
        newsRow.Id = self.posts[indexPath.row].postID
        newsRow.headLines.numberOfLines = 0
        newsRow.headLines.sizeToFit()
        
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
                    newsRow.imageView1.image = imageData
                }
            }).resume()
        }
        return newsRow
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let AVstoryboard = UIStoryboard(name: "AV", bundle: nil)
        let destinationViewController = AVstoryboard.instantiateViewController(withIdentifier: "NewsDetailedViewController") as! NewsDetailedViewController
        
       // destinationViewController.getPhotoCourtesy = posts[indexPath.row].imageCourtesy
       // destinationViewController.getContent = posts[indexPath.row].newsContent
        let postDate = CommonUtils.convertFromTimestamp(seconds: posts[indexPath.row].timestamp)
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MM-dd-yyyy"
        let postDateDate = dateFormatter.date(from: postDate)
        
        let dateFormatter2 = DateFormatter()
        dateFormatter2.dateFormat = "MMM dd, yyyy. HH':'mm"
        let currentDateString: String = dateFormatter2.string(from: postDateDate!)
        print("Current date is \(currentDateString)")
       // destinationViewController.getLocationandTimestamp = posts[indexPath.row].newsLocation + " - " + currentDateString
        
       // destinationViewController.likes = posts[indexPath.row].postLikes
       // destinationViewController.dislikes = posts[indexPath.row].postDislikes
        destinationViewController.postId = posts[indexPath.row].postID
        //destinationViewController.getPhotoURL = posts[indexPath.row].photoUrl
        destinationViewController.getPostedBy = posts[indexPath.row].userid
        self.navigationController?.pushViewController(destinationViewController, animated: true)
        let rowDataPostID = posts[indexPath.row].postID
    }
}

