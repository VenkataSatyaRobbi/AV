//
//  NewsFeedEntertainmentViewController.swift
//  AmericasVision
//
//  Created by Venkata Satya R Robbi on 5/6/18.
//  Copyright © 2018 zeroGravity. All rights reserved.
//

import UIKit
import FirebaseAuth
import FirebaseDatabase
import FirebaseStorage

class NewsEntertainmentViewController: UIViewController{
    
    @IBOutlet weak var NewsFeedEntertainmentHomeButton: UIBarButtonItem!
    @IBOutlet var label: UILabel!
    
    @IBOutlet weak var entertainmentTableview: UITableView!
    
    var posts = [Post]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        entertainmentTableview.register(NewsTableViewCell.self, forCellReuseIdentifier: "NewsTableViewCell")
        entertainmentTableview.dataSource = self
        entertainmentTableview.delegate = self
        view.backgroundColor = UIColor.white
        sideMenus()
        loadPosts()
    }
    
    func sideMenus(){
        if revealViewController() != nil {
            NewsFeedEntertainmentHomeButton.target = revealViewController()
            NewsFeedEntertainmentHomeButton.action = #selector(SWRevealViewController.revealToggle(_:))
            revealViewController().rearViewRevealWidth = 260
            view.addGestureRecognizer(self.revealViewController().panGestureRecognizer())
        }
    }
    
    
    func loadPosts(){
        Database.database().reference().child("posts").queryOrdered(byChild: "category").queryEqual(toValue: "Entertainment").observe(.childAdded) { (snapshot: DataSnapshot) in
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
                let post = Post(captionText: captionText, photoUrlString: photoUrlString, postCategoryString: postCategoryString, postTitleString: postTitleString, postLikesInt: postLikesInt, postDislikesInt: postDislikesInt, postCommentsInt: postCommentsInt, postIDString: postIDString, useridString: useridString, timeStampDouble: timestamp, imageCourtesyString: photoCourtesyString, newsLocationString: newsLocationString, newsContentString: newsContentString)
                self.posts.append(post)
                print("loading posts..\(self.posts.count)")
                self.entertainmentTableview.reloadData()
                //                if (self.posts.count > 4){
                //                    self.setImagesInPageView()
                //                }
            }
        }
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
    }
    
}


extension NewsEntertainmentViewController:UITableViewDataSource,UITableViewDelegate{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return posts.count
    }
    
    func tableView(_ tableView: UITableView,heightForRowAt indexPath: IndexPath) -> CGFloat{
        let row = indexPath.row
        if row == 0 {
            return 165
        }else{
            let attributes = [NSAttributedStringKey.font: UIFont.systemFont(ofSize: 14)]
            let approximateWidth = tableView.layer.frame.width - 20
            let size = CGSize(width: approximateWidth, height:1000)
            let estimatedSize = NSString(string: posts[indexPath.row].caption!).boundingRect(with: size, options: .usesLineFragmentOrigin, attributes: attributes, context: nil)
            let height = estimatedSize.height + 120
            return height
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let row = indexPath.row
        if row == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "FeedsTableViewCell", for: indexPath) as? FeedsTableViewCell
            cell?.registerCollectoinView(datasource: self)
            return cell!
        }else{
            let newsRow = tableView.dequeueReusableCell(withIdentifier: "NewsTableViewCell", for: indexPath) as! NewsTableViewCell
            //newsRow.accessoryType = UITableViewCellAccessoryType.disclosureIndicator
            newsRow.headLines.text = posts[indexPath.row].postTitle
            newsRow.caption.text = posts[indexPath.row].caption
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
                        print(imageData)
                        newsRow.imageView1.image = imageData
                    }
                }).resume()
            }
            return newsRow
        }
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let AVstoryboard = UIStoryboard(name: "AV", bundle: nil)
        let destinationViewController = AVstoryboard.instantiateViewController(withIdentifier: "NewsDetailedViewController") as! NewsDetailedViewController
        
        
        destinationViewController.postId = posts[indexPath.row].postID
       
        self.navigationController?.pushViewController(destinationViewController, animated: true)
        
        let rowDataPostID = posts[indexPath.row].postID
        print("rowdata ID value: \(rowDataPostID)")
    }
}

extension NewsEntertainmentViewController:UICollectionViewDataSource,UICollectionViewDelegate{
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        //  return 2
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let row = indexPath.row
        //if row < 2{
        if row < 1{
            print("fun the loading posts..\(self.posts.count)")
            let newsRow = collectionView.dequeueReusableCell(withReuseIdentifier:"SlideCollectionViewCell", for: indexPath) as! SlideCollectionViewCell
            newsRow.headlines.text = posts[indexPath.row].postTitle
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
                        newsRow.cellImage.image = imageData
                    }
                }).resume()
            }
            return newsRow
        }else{
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier:"SlideCollectionViewCell", for: indexPath) as! SlideCollectionViewCell
            return cell
        }
        
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let AVstoryboard = UIStoryboard(name: "AV", bundle: nil)
        let destinationViewController = AVstoryboard.instantiateViewController(withIdentifier: "NewsDetailedViewController") as! NewsDetailedViewController
        
        destinationViewController.postId = posts[indexPath.row].postID
        self.navigationController?.pushViewController(destinationViewController, animated: true)
        
        let rowDataPostID = posts[indexPath.row].postID
        print("rowdata ID value: \(rowDataPostID)")
    }
}
