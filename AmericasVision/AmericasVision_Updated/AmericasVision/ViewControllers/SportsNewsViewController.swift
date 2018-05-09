//
//  SportsViewController.swift
//  AmericasVision
//
//  Created by Mohan Dola on 08/05/18.
//  Copyright © 2018 zeroGravity. All rights reserved.
//

import UIKit
import FirebaseAuth
import FirebaseDatabase
import FirebaseStorage

class SportsNewsViewController: UIViewController ,UICollectionViewDelegate,UICollectionViewDataSource{
    
    @IBOutlet weak var homeButton: UIBarButtonItem!
    @IBOutlet weak var SportsNewsCollectionView: UICollectionView!
     @IBOutlet weak var SportsNewsCollectionView1: UICollectionView!
    var posts = [Post]()
    
//    let scrollView = UIScrollView(frame: CGRect(x:0, y:0, width:320,height: 300))
//    var colors:[UIColor] = [UIColor.red, UIColor.blue, UIColor.green, UIColor.yellow]
//    var frame: CGRect = CGRect(x:0, y:0, width:0, height:0)
//    var pageControl : UIPageControl = UIPageControl(frame: CGRect(x:50,y: 300, width:200, height:50))
    
    override func viewDidLoad() {
        super.viewDidLoad()
//        configurePageControl()
//        scrollView.delegate = self as? UIScrollViewDelegate
//        scrollView.isPagingEnabled = true
//        self.view.addSubview(scrollView)
//        for index in 0..<4 {
//            frame.origin.x = self.scrollView.frame.size.width * CGFloat(index)
//            frame.size = self.scrollView.frame.size
//            let subView = UIView(frame: frame)
//            subView.backgroundColor = colors[index]
//            self.scrollView .addSubview(subView)
//        }
//        self.scrollView.contentSize = CGSize(width:self.scrollView.frame.size.width * 4,height: self.scrollView.frame.size.height)
//        pageControl.addTarget(self, action: #selector(self.changePage(sender:)), for: UIControlEvents.valueChanged)
        view.backgroundColor = UIColor.white
        
        SportsNewsCollectionView.isHidden = false
        SportsNewsCollectionView.dataSource = self
        
        SportsNewsCollectionView1.isHidden = false
        SportsNewsCollectionView1.dataSource = self
        
        view.backgroundColor = UIColor.white
        if let flowLayout = SportsNewsCollectionView.collectionViewLayout as? UICollectionViewFlowLayout {
            flowLayout.scrollDirection = .horizontal
        }
        
        if let flowLayout = SportsNewsCollectionView1.collectionViewLayout as? UICollectionViewFlowLayout {
            flowLayout.scrollDirection = .vertical
        }
        
        sideMenus()
        loadPosts()
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
                self.SportsNewsCollectionView.reloadData()
                 self.SportsNewsCollectionView1.reloadData()
                
                
            }
        }
    }
    
//    func configurePageControl() {
//        // The total number of pages that are available is based on how many available colors we have.
//        self.pageControl.numberOfPages = colors.count
//        self.pageControl.currentPage = 0
//        self.pageControl.tintColor = UIColor.red
//        self.pageControl.pageIndicatorTintColor = UIColor.black
//        self.pageControl.currentPageIndicatorTintColor = UIColor.green
//        self.view.addSubview(pageControl)
//    }
    
    // MARK : TO CHANGE WHILE CLICKING ON PAGE CONTROL
//    @objc func changePage(sender: AnyObject) -> () {
//        let x = CGFloat(pageControl.currentPage) * scrollView.frame.size.width
//        scrollView.setContentOffset(CGPoint(x:x, y:0), animated: true)
//    }
//
//    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
//        let pageNumber = round(scrollView.contentOffset.x / scrollView.frame.size.width)
//        pageControl.currentPage = Int(pageNumber)
//    }
    
    func sideMenus(){
        if revealViewController() != nil {
            revealViewController().rearViewRevealWidth = 260
            view.addGestureRecognizer(self.revealViewController().panGestureRecognizer())
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        sideMenus()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return posts.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let item = SportsNewsCollectionView.dequeueReusableCell(withReuseIdentifier: "PostCollectionViewCell", for: indexPath) as! PostCollectionViewCell
        
        item.PostCollectionViewContent.isScrollEnabled = false;//
        item.PostCollectionViewContent.text  = posts[indexPath.item].caption
        item.PostCollectionViewHeadlines.text = posts[indexPath.item].postTitle
        item.PostCollectionViewLikes.text = "\(posts[indexPath.item].postLikes)"
        item.PostCollectionViewDislikes.text = "\(posts[indexPath.item].postDislikes)"
        item.PostCollectionViewComments.text = "\(posts[indexPath.item].postComments)"
        
        
        let item1 = SportsNewsCollectionView1.dequeueReusableCell(withReuseIdentifier: "PostCollectionViewCell", for: indexPath) as! PostCollectionViewCell
        
        item1.PostCollectionViewContent.isScrollEnabled = false;//
        item1.PostCollectionViewContent.text  = posts[indexPath.item].caption
        item1.PostCollectionViewHeadlines.text = posts[indexPath.item].postTitle
        item1.PostCollectionViewLikes.text = "\(posts[indexPath.item].postLikes)"
        item1.PostCollectionViewDislikes.text = "\(posts[indexPath.item].postDislikes)"
        item1.PostCollectionViewComments.text = "\(posts[indexPath.item].postComments)"
        
        
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
