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

class NewsFeedEntertainmentViewController: UIViewController, UIScrollViewDelegate, UICollectionViewDataSource {
    
    @IBOutlet weak var NewsFeedEntertainmentHomeButton: UIBarButtonItem!
    @IBOutlet weak var NewsFeedEntertainmentCollectionView: UICollectionView!
     @IBOutlet weak var NewsFeedScrollview: UIScrollView!
    @IBOutlet var label: UILabel!
    var posts = [Post]()
    
   // let scrollView = UIScrollView(frame: CGRect(x:0, y:0, width:UIScreen.main.bounds.width,height: 300))
    
    let scrollView = UIScrollView(frame: CGRect(x:0,y: 10, width:UIScreen.main.bounds.width, height:300))
   
    var frame: CGRect = CGRect(x:0, y:0, width:0, height:0)
    var pageControl : UIPageControl = UIPageControl(frame: CGRect(x:50,y: 300, width:200, height:50))
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configurePageControl()
        view.backgroundColor = UIColor.white
        NewsFeedEntertainmentCollectionView.isHidden = false
        NewsFeedEntertainmentCollectionView.dataSource = self
        
        view.backgroundColor = UIColor.white
        
       NewsFeedScrollview.delegate = self as? UIScrollViewDelegate
        NewsFeedScrollview .isScrollEnabled = true
    
        
    
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
    
    override func viewDidLayoutSubviews() {
        print("inside did layout sub views")
        scrollView.delegate = self as? UIScrollViewDelegate
        scrollView.isPagingEnabled = true
        
        self.view.addSubview(scrollView)
        
        //        for index in 0..<7 {
        //            frame.origin.x = self.scrollView.frame.size.width * CGFloat(index)
        //            frame.size = self.scrollView.frame.size
        //            let subView = UIView(frame: frame)
        //            subView.backgroundColor = colors[index]
        //            self.scrollView.addSubview(subView)
        //        }
        //        self.scrollView.contentSize = CGSize(width:self.scrollView.frame.size.width * 7,height: self.scrollView.frame.size.height)
        //        pageControl.addTarget(self, action: #selector(self.changePage(sender:)), for: UIControlEvents.valueChanged)
        
        
       
        
        
        
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
        Database.database().reference().child("posts").queryOrdered(byChild: "category").queryEqual(toValue: "Category3").observe(.childAdded) { (snapshot: DataSnapshot) in
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
                print("loading posts..\(self.posts.count)")
                print(self.posts)
                self.NewsFeedEntertainmentCollectionView.reloadData()
                if (self.posts.count > 4){
                    self.setImagesInPageView()
                }
            }
        }
        
    }
    
    
    
    func setImagesInPageView() {
        print("inside setImagesForPageView")
        
        for index in 0..<4{
            let AVPostStorageRef = Storage.storage().reference(forURL: posts[posts.count - 1 - index].photoUrl)
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
                        
                       
                        
                        
                        print("in getImages")
                        print(imageData)
                        //self.pageViewImages?.append(imageData)
                        //print("print images array first item")
                        //print(self.pageViewImages?[0])
                        //let pageViewImagesCount: Int = (pageViewImages?.count)!
                       // for index in 0..< 6 {
                       // self.frame.origin.x = self.scrollView.frame.size.width * CGFloat(index)
                        
                        self.frame.origin.x = self.scrollView.frame.size.width * CGFloat(index)
                        self.frame.size = self.scrollView.frame.size
                        let subView = UIImageView(frame: self.frame)
                        subView.image = imageData
                        self.scrollView.addSubview(subView)
                       
                        
                        let titleHeader = UILabel()
                        titleHeader.text = "Latest News"
                        let subView1 = UILabel(frame: self.frame)
                       //
                        subView1.text = titleHeader.text
                        subView1.textColor = UIColor.white
                        self.scrollView.addSubview(subView1)
                        
                        let title = UILabel()
                        title.text = "title of the latest news shown the below image with contant"
                        let subViewtitle = UILabel(frame: CGRect(x:0, y: 175, width: 300, height: 21))
                        //  let subViewtitle = title
                        subViewtitle.text = title.text
                        subViewtitle.textColor = UIColor.white
                        self.scrollView.addSubview(subViewtitle)
                        
                       
                        
                       // }
                    }
                }).resume()
            }
        }
        self.scrollView.contentSize = CGSize(width:self.scrollView.frame.size.width * 4 , height: self.scrollView.frame.size.height)
        
        
        self.pageControl.addTarget(self, action: #selector(self.changePage(sender:)), for: UIControlEvents.valueChanged)
        
       
        
    }

    
    func configurePageControl() {
        // The total number of pages that are available is based on how many available colors we have.
        self.pageControl.numberOfPages = 8
        self.pageControl.currentPage = 0
        self.pageControl.tintColor = UIColor.red
        self.pageControl.pageIndicatorTintColor = UIColor.black
        self.pageControl.currentPageIndicatorTintColor = UIColor.green
        
        // Change the text accordingly
        let title = UILabel()
        title.text = "title of the latest news shown the below image with contant"
        let subViewtitle = UILabel(frame: CGRect(x:0, y: 175, width: 300, height: 21))
        //  let subViewtitle = title
        subViewtitle.text = title.text
        subViewtitle.textColor = UIColor.white
        self.pageControl.addSubview(subViewtitle)
        
        self.view.addSubview(pageControl)
    }
    
    // MARK : TO CHANGE WHILE CLICKING ON PAGE CONTROL
    @objc func changePage(sender: AnyObject) -> () {
        let x = CGFloat(pageControl.currentPage) * scrollView.frame.size.width
      scrollView.setContentOffset(CGPoint(x:x, y:0), animated: true)
        
       
        
    }
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        let pageNumber = round(scrollView.contentOffset.x / scrollView.frame.size.width)
        pageControl.currentPage = Int(pageNumber)
        
       // let pageWidth:CGFloat = scrollView.frame.width
       // let currentPage:CGFloat = floor((scrollView.contentOffset.x-pageWidth/2)/pageWidth)+1
       //  pageControl.currentPage = Int(currentPage)
        // Change the text accordingly
        
        UIView.animate(withDuration: 0.5, delay: 0.0, options: UIViewAnimationOptions.curveEaseOut, animations: {
            let x = CGFloat(self.pageControl.currentPage) * self.scrollView.frame.size.width
            self.scrollView.setContentOffset(CGPoint(x:x, y:0), animated: true)
        }, completion: nil)
        
        
        
       
    }
    
    //    override func viewWillAppear(_ animated: Bool) {
    //        sideMenus()
    //    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
       
       
        
       
        
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //    private func numberOfSections(in tableView: UITableView) -> Int {
    //        // #warning Incomplete implementation, return the number of sections
    //        return 0
    //    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return posts.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let item = NewsFeedEntertainmentCollectionView.dequeueReusableCell(withReuseIdentifier: "PostCollectionViewCell", for: indexPath) as! PostCollectionViewCell
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
                    print("in collection view...\(imageData)")
                    item.PostCollectionViewImage.image = imageData
                }
            }).resume()
        }
        return item
    }
    
}
