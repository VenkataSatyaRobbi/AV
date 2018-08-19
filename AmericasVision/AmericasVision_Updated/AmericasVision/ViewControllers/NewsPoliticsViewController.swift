//
//  PoliticsViewController.swift
//  AmericasVision
//
//  Created by Mohan Dola on 12/08/18.
//  Copyright © 2018 zeroGravity. All rights reserved.
//

import UIKit
import FirebaseAuth
import FirebaseDatabase
import FirebaseStorage

class NewsPoliticsViewController: UITableViewController{
    
    @IBOutlet weak var NewsFeedPoliticsHomeButton: UIBarButtonItem!
     
    var posts = [Post]()
    var imageHeight:CGFloat = 90
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.register(NewsTableViewCell.self, forCellReuseIdentifier: "NewsTableViewCell")
        //  Register cell classes
        tableView?.dataSource = self
        tableView?.delegate = self
        self.tableView.backgroundColor = UIColor.lightGray
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
        Database.database().reference().child("posts").queryOrdered(byChild: "category").queryEqual(toValue: "Politics").observe(.childAdded) { (snapshot: DataSnapshot) in
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
                self.tableView.reloadData()
            }
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return posts.count
    }
    
    override func tableView(_ tableView: UITableView,heightForRowAt indexPath: IndexPath) -> CGFloat{
        let attributes = [NSAttributedStringKey.font: UIFont.systemFont(ofSize: 14)]
        let approximateWidth = tableView.layer.frame.width - 20
        let size = CGSize(width: approximateWidth, height:10000)
        let estimatedSize = NSString(string: posts[indexPath.row].caption!).boundingRect(with: size, options: .usesLineFragmentOrigin, attributes: attributes, context: nil)
        let height = estimatedSize.height + 110 + 10
        return height
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let newsRow = tableView.dequeueReusableCell(withIdentifier: "NewsTableViewCell", for: indexPath) as! NewsTableViewCell
        newsRow.headLines.text = posts[indexPath.row].postTitle
        newsRow.caption.text = posts[indexPath.row].caption
        posts[indexPath.row].caption = newsRow.caption.text
        newsRow.Id = self.posts[indexPath.row].postID
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
                    newsRow.imageView1.image = imageData
                }
            }).resume()
        }
        return newsRow
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        
        let AVstoryboard = UIStoryboard(name: "AV", bundle: nil)
        let destinationViewController = AVstoryboard.instantiateViewController(withIdentifier: "NewsDetailedViewController") as! NewsDetailedViewController
        destinationViewController.postId = posts[indexPath.row].postID
      
        
        self.navigationController?.pushViewController(destinationViewController, animated: true)
        
        let rowDataPostID = posts[indexPath.row].postID
        print("rowdata ID value: \(rowDataPostID)")
        
    }
    
}

