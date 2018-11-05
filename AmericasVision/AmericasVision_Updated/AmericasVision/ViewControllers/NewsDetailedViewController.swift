//
//  NewsDetailedViewController.swift
//  AmericasVision
//
//  Created by Venkata Satya R Robbi on 5/15/18.
//  Copyright © 2018 zeroGravity. All rights reserved.
//

import UIKit
import FirebaseAuth
import FirebaseDatabase
import FirebaseStorage

class CommentsTableCell:UITableViewCell{
    
    let profileImageView: UIImageView = {
        let view = UIImageView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.layer.cornerRadius = 15
        view.clipsToBounds = true
        return view
    }()
    
    let comment: UILabel = {
        let commentlabel = UILabel()
        commentlabel.textColor = UIColor.black
        commentlabel.font = UIFont(name: "Verdana", size: 13)
        commentlabel.translatesAutoresizingMaskIntoConstraints = false
        commentlabel.numberOfLines = 0
        commentlabel.sizeToFit()
        commentlabel.textAlignment = .justified
        commentlabel.lineBreakMode = .byWordWrapping
        return commentlabel
    }()
    
    let commentedDate: UILabel = {
        let commentedDateLabel = UILabel()
        commentedDateLabel.textColor = UIColor.black
        commentedDateLabel.font = UIFont(name: "Verdana", size: 13)
        commentedDateLabel.translatesAutoresizingMaskIntoConstraints = false
        commentedDateLabel.numberOfLines = 0
        commentedDateLabel.sizeToFit()
        commentedDateLabel.textAlignment = .justified
        return commentedDateLabel
    }()
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.addSubview(profileImageView)
        self.addSubview(comment)
        self.addSubview(commentedDate)
        
        profileImageView.leftAnchor.constraint(equalTo: leftAnchor, constant:10).isActive = true
        profileImageView.heightAnchor.constraint(equalToConstant:30).isActive = true
        profileImageView.widthAnchor.constraint(equalToConstant:30).isActive = true
        profileImageView.topAnchor.constraint(equalTo: topAnchor, constant:5).isActive = true
        
        comment.leftAnchor.constraint(equalTo: leftAnchor, constant:50).isActive = true
        //comment.heightAnchor.constraint(equalToConstant:30).isActive = true
        comment.widthAnchor.constraint(equalToConstant: UIScreen.main.bounds.width - 60).isActive = true
        comment.topAnchor.constraint(equalTo: topAnchor, constant:5).isActive = true
        
        commentedDate.leftAnchor.constraint(equalTo: leftAnchor, constant:50).isActive = true
        commentedDate.heightAnchor.constraint(equalToConstant:20).isActive = true
        commentedDate.widthAnchor.constraint(equalToConstant:self.frame.width).isActive = true
        //commentedDate.topAnchor.constraint(equalTo: topAnchor, constant: 50).isActive = true
        
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
}

class NewsDetailedViewController: UIViewController,UIScrollViewDelegate, UITextViewDelegate {
    
    let cellSpacingHeight: CGFloat = 5
    
    var NewsDetailedVCImage : UIImageView = {
        let NewsDetailedVCImageview = UIImageView()
        NewsDetailedVCImageview.translatesAutoresizingMaskIntoConstraints = false
        let image = UIImage(named: "profile")
        NewsDetailedVCImageview.image = image
        return NewsDetailedVCImageview
    }()
    
    let NewsDetailedVCImageCourtesy: UILabel = {
        let NewsDetailedVCImageCourtesylabel = UILabel()
        NewsDetailedVCImageCourtesylabel.translatesAutoresizingMaskIntoConstraints = false
        NewsDetailedVCImageCourtesylabel.numberOfLines = 0
        NewsDetailedVCImageCourtesylabel.sizeToFit()
        //NewsDetailedVCImageCourtesylabel.font = UIFont.systemFont(ofSize: 13)
        NewsDetailedVCImageCourtesylabel.font = UIFont(name: "Verdana", size: 13)
        NewsDetailedVCImageCourtesylabel.textColor = UIColor.gray
        NewsDetailedVCImageCourtesylabel.textAlignment = .justified
        return NewsDetailedVCImageCourtesylabel
    }()
    
    let NewsDetailedVCNewsContent: UILabel = {
        let NewsDetailedVCNewsContentlabel = UILabel()
        NewsDetailedVCNewsContentlabel.translatesAutoresizingMaskIntoConstraints = false
        NewsDetailedVCNewsContentlabel.numberOfLines = 0
        NewsDetailedVCNewsContentlabel.sizeToFit()
        //NewsDetailedVCNewsContentlabel.font = UIFont.systemFont(ofSize: 15)
        NewsDetailedVCNewsContentlabel.font = UIFont(name: "Verdana", size: 15)
        NewsDetailedVCNewsContentlabel.textAlignment = .justified
        NewsDetailedVCNewsContentlabel.lineBreakMode = .byWordWrapping
        return NewsDetailedVCNewsContentlabel
    }()
    
    var likesCount: NSNumber = 0
    var dislikesCount: NSNumber = 0
    
    let postedBy: UILabel = {
        let postedBylabel = UILabel()
        postedBylabel.translatesAutoresizingMaskIntoConstraints = false
        postedBylabel.numberOfLines = 0
        postedBylabel.sizeToFit()
        postedBylabel.font = UIFont(name: "Verdana", size: 15)
        postedBylabel.textColor = UIColor.blue
        postedBylabel.textAlignment = .justified
        return postedBylabel
    }()
    
    let likeButton: UIButton = {
        let likeButtonbutton = UIButton()
        let likeimage = UIImage(named: "like")
        likeButtonbutton.translatesAutoresizingMaskIntoConstraints = false
        //likeButtonbutton.setImage(UIImage(named: "like"), for: .normal)
        likeButtonbutton.setImage(likeimage?.withRenderingMode(UIImageRenderingMode.alwaysTemplate), for: .normal)
        likeButtonbutton.tintColor = UIColor.gray
        return likeButtonbutton
    }()
    
    let dislikeButton: UIButton = {
        let dislikeButtonbutton = UIButton()
        let dislikeimage = UIImage(named: "dislike")
        dislikeButtonbutton.translatesAutoresizingMaskIntoConstraints = false
        //dislikeButtonbutton.setImage(UIImage(named: "dislike"), for: .normal)
        dislikeButtonbutton.setImage(dislikeimage?.withRenderingMode(UIImageRenderingMode.alwaysTemplate), for: .normal)
        dislikeButtonbutton.tintColor = UIColor.gray
        return dislikeButtonbutton
    }()
    
    /*let oldCommentsLabel: UILabel = {
     let label = UILabel()
     label.translatesAutoresizingMaskIntoConstraints = false
     label.numberOfLines = 0
     label.sizeToFit()
     label.text = "Previous Comments"
     label.font = UIFont.boldSystemFont(ofSize: 13)
     label.textAlignment = .justified
     label.textColor = UIColor.blue
     return label
     }()*/
    
    let writeCommentLabel: UILabel = {
        let writeCommentLabel = UILabel()
        writeCommentLabel.translatesAutoresizingMaskIntoConstraints = false
        //writeCommentLabel.text = "Comments"
        writeCommentLabel.numberOfLines = 0
        writeCommentLabel.sizeToFit()
        writeCommentLabel.font = UIFont(name: "Verdana", size: 14)
        writeCommentLabel.textAlignment = .justified
        writeCommentLabel.textColor = UIColor.blue
        return writeCommentLabel
    }()
    
    let writeComment: UITextView = {
        let writeCommenttext = UITextView()
        writeCommenttext.translatesAutoresizingMaskIntoConstraints = false
        writeCommenttext.layer.borderColor = UIColor.lightGray.cgColor
        writeCommenttext.layer.borderWidth = 1.0;
        writeCommenttext.layer.cornerRadius = 5.0;
        writeCommenttext.font = UIFont(name: "Verdana", size: 13)
        return writeCommenttext
    }()
    
    /* let oldComments: UILabel = {
     let oldCommentslabel = UILabel()
     oldCommentslabel.translatesAutoresizingMaskIntoConstraints = false
     oldCommentslabel.numberOfLines = 0
     oldCommentslabel.sizeToFit()
     oldCommentslabel.font = UIFont.systemFont(ofSize: 13)
     oldCommentslabel.textAlignment = .justified
     oldCommentslabel.backgroundColor = UIColor.lightGray
     oldCommentslabel.layer.borderColor = UIColor.lightGray.cgColor
     oldCommentslabel.layer.borderWidth = 1.0;
     oldCommentslabel.layer.cornerRadius = 5.0;
     return oldCommentslabel
     }()*/
    
    let NewsDetailedVCDateAndLocation: UILabel = {
        let NewsDetailedVCDateAndLocationlabel = UILabel()
        NewsDetailedVCDateAndLocationlabel.translatesAutoresizingMaskIntoConstraints = false
        NewsDetailedVCDateAndLocationlabel.numberOfLines = 0
        NewsDetailedVCDateAndLocationlabel.sizeToFit()
        NewsDetailedVCDateAndLocationlabel.font = UIFont(name: "Verdana", size: 14)
        NewsDetailedVCDateAndLocationlabel.textAlignment = .justified
        return NewsDetailedVCDateAndLocationlabel
    }()
    
    let likeLabel: UILabel = {
        let likeLabel = UILabel()
        likeLabel.translatesAutoresizingMaskIntoConstraints = false
        likeLabel.numberOfLines = 0
        likeLabel.sizeToFit()
        likeLabel.font = UIFont(name: "Verdana", size: 14)
        likeLabel.textAlignment = .justified
        return likeLabel
    }()
    
    let dislikeLabel: UILabel = {
        let dislikeLabel = UILabel()
        dislikeLabel.translatesAutoresizingMaskIntoConstraints = false
        dislikeLabel.numberOfLines = 0
        dislikeLabel.sizeToFit()
        dislikeLabel.font = UIFont(name: "Verdana", size: 14)
        dislikeLabel.textAlignment = .justified
        return dislikeLabel
    }()
    
    let oldCommentsView: UIView = {
        let oldCommentsView = UIView()
        oldCommentsView.translatesAutoresizingMaskIntoConstraints = false
        return oldCommentsView
    }()
    
    let postCommentButton: UIButton = {
        let postCommentButton = UIButton(type: UIButtonType.system)
        postCommentButton.translatesAutoresizingMaskIntoConstraints = false
        postCommentButton.backgroundColor = UIColor(red: 6/255, green: 90/255, blue: 157/255, alpha: 1)
        postCommentButton.layer.cornerRadius = 2.0
        postCommentButton.setTitle("Post Comment", for: .normal)
        postCommentButton.setTitleColor(.white, for: .normal)
        return postCommentButton
    }()
    
    var postId = String()
    var postedUserId = String()
    var likeToggle: Bool = false
    var getPostedBy = String()
    var username = String()
    var postedDate = String()
    var photoUrl = String()
    var comments = [PostComment]()
    var commentKey = String()
    var userAlreadyLiked: Bool = false
    var userAlreadyDisliked: Bool = false
    var commentedDate = String()
    var currentUserid: String = AVAuthService.getCurrentUserId()
    var commentDateDouble = Double()
    var commentedUserId = String()
    
    @IBOutlet weak var scrollView: UIScrollView!
    var tableView: UITableView = UITableView()
    
    override func viewDidAppear(_ animated: Bool) {
        DBProvider.instance.userRef.child(postedUserId).observe(.value) { (snapshot) in
            let userFirstName = (snapshot.value as! NSDictionary)["FirstName"] as? String
            let userLastName = (snapshot.value as! NSDictionary)["LastName"] as? String
            self.postedBy.text = "Posted by: " + userFirstName! + ", " + userLastName!
        }
        
        var commentsHeight:CGFloat = 0
        let approximateWidth = UIScreen.main.bounds.width - 60
        //let approximateWidth = self.scrollView.frame.width - 60
        comments.forEach { comment in
            let hgt = CommonUtils.heightForView(text: comment.comments, font:UIFont(name: "Verdana", size: 13)! ,width: approximateWidth)
            //let height = hgt < 40 ? 40: ceil(hgt)
            let height = ceil(hgt)
            commentsHeight = commentsHeight + height + 40
            insertPostedCommentInTable(comment: comment)
        }
        
        NewsDetailedVCImage.topAnchor.constraint(equalTo: scrollView.topAnchor, constant:1).isActive = true
        NewsDetailedVCImage.heightAnchor.constraint(equalToConstant:200).isActive = true
        NewsDetailedVCImage.widthAnchor.constraint(equalToConstant:self.view.frame.width).isActive = true
        
        NewsDetailedVCImageCourtesy.leftAnchor.constraint(equalTo: scrollView.leftAnchor, constant:10).isActive = true
        NewsDetailedVCImageCourtesy.topAnchor.constraint(equalTo: scrollView.topAnchor, constant:200).isActive = true
        NewsDetailedVCImageCourtesy.heightAnchor.constraint(equalToConstant:20).isActive = true
        NewsDetailedVCImageCourtesy.widthAnchor.constraint(equalToConstant:(self.view.frame.width)-20).isActive = true
        
        postedBy.topAnchor.constraint(equalTo: scrollView.topAnchor, constant:225).isActive = true
        postedBy.leftAnchor.constraint(equalTo: scrollView.leftAnchor, constant:10).isActive = true
        postedBy.heightAnchor.constraint(equalToConstant:20).isActive = true
        postedBy.widthAnchor.constraint(equalToConstant:(self.view.frame.width)-20).isActive = true
        
        NewsDetailedVCDateAndLocation.leftAnchor.constraint(equalTo: scrollView.leftAnchor, constant:10).isActive = true
        NewsDetailedVCDateAndLocation.topAnchor.constraint(equalTo: scrollView.topAnchor, constant:250).isActive = true
        NewsDetailedVCDateAndLocation.heightAnchor.constraint(equalToConstant:20).isActive = true
        NewsDetailedVCDateAndLocation.widthAnchor.constraint(equalToConstant:(self.view.frame.width)-20).isActive = true
        
        likeButton.topAnchor.constraint(equalTo: scrollView.topAnchor, constant:275).isActive = true
        likeButton.leftAnchor.constraint(equalTo: scrollView.leftAnchor, constant:10).isActive = true
        likeButton.heightAnchor.constraint(equalToConstant:20).isActive = true
        likeButton.addTarget(self,action: #selector(self.likesAction(_:)),for: .touchUpInside)
        
        likeLabel.topAnchor.constraint(equalTo: scrollView.topAnchor, constant:275).isActive = true
        likeLabel.leftAnchor.constraint(equalTo: scrollView.leftAnchor, constant:10 + 30).isActive = true
        likeLabel.heightAnchor.constraint(equalToConstant:20).isActive = true
        
        dislikeButton.topAnchor.constraint(equalTo: scrollView.topAnchor, constant:275).isActive = true
        dislikeButton.leftAnchor.constraint(equalTo: scrollView.leftAnchor, constant:10 + 30 + 70).isActive = true
        dislikeButton.heightAnchor.constraint(equalToConstant:20).isActive = true
        dislikeButton.addTarget(self,action: #selector(self.dislikeAction(_:)),for: .touchUpInside)
        
        dislikeLabel.topAnchor.constraint(equalTo: scrollView.topAnchor, constant:275).isActive = true
        dislikeLabel.leftAnchor.constraint(equalTo: scrollView.leftAnchor, constant:10 + 30 + 70 + 30).isActive = true
        dislikeLabel.heightAnchor.constraint(equalToConstant:20).isActive = true
        
        NewsDetailedVCNewsContent.topAnchor.constraint(equalTo: scrollView.topAnchor, constant:300).isActive = true
        NewsDetailedVCNewsContent.leftAnchor.constraint(equalTo: scrollView.leftAnchor, constant:10).isActive = true
        //let contentHeight = calculateHeight(text:NewsDetailedVCNewsContent.text!)
        let contentHeight = CommonUtils.heightForView(text:NewsDetailedVCNewsContent.text!, font:UIFont(name: "Verdana", size: 15)!, width:self.scrollView.frame.width - 20)
        NewsDetailedVCNewsContent.heightAnchor.constraint(equalToConstant:contentHeight).isActive = true
        NewsDetailedVCNewsContent.widthAnchor.constraint(equalToConstant:self.view.frame.width-20).isActive = true
        
        writeCommentLabel.leftAnchor.constraint(equalTo:scrollView.leftAnchor, constant: 10).isActive = true
        writeCommentLabel.topAnchor.constraint(equalTo:scrollView.topAnchor, constant: 310 + contentHeight).isActive = true
        writeCommentLabel.heightAnchor.constraint(equalToConstant:20).isActive = true
        writeCommentLabel.widthAnchor.constraint(equalToConstant:self.view.frame.width-20).isActive = true
        //writeCommentLabel.text = "\(getCommentsCount()) Comments"
        
        writeComment.leftAnchor.constraint(equalTo:scrollView.leftAnchor, constant: 10).isActive = true
        writeComment.topAnchor.constraint(equalTo: scrollView.topAnchor, constant:330 + contentHeight).isActive = true
        writeComment.heightAnchor.constraint(equalToConstant:50).isActive = true
        writeComment.widthAnchor.constraint(equalToConstant:self.view.frame.width-20).isActive = true
        
        postCommentButton.leftAnchor.constraint(equalTo:scrollView.leftAnchor, constant: 10).isActive = true
        postCommentButton.topAnchor.constraint(equalTo: scrollView.topAnchor, constant:385 + contentHeight).isActive = true
        postCommentButton.heightAnchor.constraint(equalToConstant:30).isActive = true
        postCommentButton.widthAnchor.constraint(equalToConstant:self.view.frame.width-20).isActive = true
        postCommentButton.addTarget(self,action: #selector(self.postCommentAction(_:)),for: .touchUpInside)
        
        /*oldCommentsLabel.leftAnchor.constraint(equalTo: scrollView.leftAnchor, constant:10).isActive = true
         oldCommentsLabel.topAnchor.constraint(equalTo: scrollView.topAnchor, constant:350 + contentHeight).isActive = true
         oldCommentsLabel.heightAnchor.constraint(equalToConstant:20).isActive = true
         oldCommentsLabel.widthAnchor.constraint(equalToConstant:self.view.frame.width-20).isActive = true*/
        
        likeLabel.text = likesCount.stringValue
        dislikeLabel.text = dislikesCount.stringValue
        
        if comments.count > 0 {
            let indexPath = NSIndexPath(row:comments.count-1, section: 0)
            tableView.scrollToRow(at: indexPath as IndexPath, at: .bottom, animated: false)
            //tableView.frame = CGRect(x: 0, y: (415 + contentHeight), width: tableView.layer.frame.width-65, height: commentsHeight)
            tableView.frame = CGRect(x: 0, y: (425 + contentHeight), width: self.view.frame.width, height: commentsHeight)
            print("self.view.frame.width: \(self.view.frame.width)");
            self.scrollView.addSubview(tableView)
            self.scrollView.isScrollEnabled = true
        }
        scrollView.contentSize = CGSize(width: self.view.frame.size.width, height: 380 + contentHeight + commentsHeight + 50)
        //print("commentsHeight: \(commentsHeight)")
        // 40 space for bottom
        let NewsDetailAVPostStorageRef = Storage.storage().reference(forURL:photoUrl)
        NewsDetailAVPostStorageRef.downloadURL { (url, error) in
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
                    self.NewsDetailedVCImage.image = imageData
                }
            }).resume()
        }
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //self.likeButton.tintColor = UIColor.gray
        //self.dislikeButton.tintColor = UIColor.gray
        
        let postRef = DBProvider.instance.newsFeedRef.child(postId)
        postRef.child("usercomments").queryOrdered(byChild: "type").queryEqual(toValue: "Like").observeSingleEvent(of: DataEventType.value){
            (snapShot:DataSnapshot) in
            if let mycomments = snapShot.value as? NSDictionary{
                for(key,value) in mycomments{
                    if let commentDic = value as? NSDictionary{
                        let userId = commentDic["userId"] as? String
                        if userId == self.currentUserid{
                            //print("userid found")
                            self.userAlreadyLiked = true
                            self.likeButton.tintColor = UIColor.blue
                            break
                        }
                    }
                }
            }
        }
        postRef.child("usercomments").queryOrdered(byChild: "type").queryEqual(toValue: "Dislike").observeSingleEvent(of: DataEventType.value){
            (snapShot:DataSnapshot) in
            if let mycomments = snapShot.value as? NSDictionary{
                for(key,value) in mycomments{
                    if let commentDic = value as? NSDictionary{
                        let userId = commentDic["userId"] as? String
                        if userId == self.currentUserid{
                            //print("userid found");
                            self.userAlreadyDisliked = true
                            self.dislikeButton.tintColor = UIColor.red
                            break
                        }
                    }
                }
            }
        }
        
        writeComment.text = "Add a comment"
        writeComment.textColor = UIColor.lightGray
        writeComment.font = UIFont(name: "Verdana", size: 13)
        
        self.scrollView.addSubview(NewsDetailedVCImage)
        self.scrollView.addSubview(NewsDetailedVCImageCourtesy)
        self.scrollView.addSubview(postedBy)
        self.scrollView.addSubview(NewsDetailedVCDateAndLocation)
        self.scrollView.addSubview(NewsDetailedVCNewsContent)
        self.scrollView.addSubview(likeButton)
        self.scrollView.addSubview(likeLabel)
        self.scrollView.addSubview(dislikeButton)
        self.scrollView.addSubview(dislikeLabel)
        self.scrollView.addSubview(writeCommentLabel)
        self.scrollView.addSubview(writeComment)
        self.scrollView.addSubview(postCommentButton)
        //self.scrollView.addSubview(oldCommentsLabel)
        //self.scrollView.addSubview(tableView)
        
        tableView.register(CommentsTableCell.self, forCellReuseIdentifier: "CommentsTableCell")
        tableView.delegate = self
        tableView.dataSource = self
        tableView.bounces = false
        tableView.isScrollEnabled = false
        
        scrollView.isScrollEnabled = true
        scrollView.delegate = self
        self.navigationItem.title = "Details"
        writeComment.delegate = self
        self.postCommentButton.isEnabled = false
        self.postCommentButton.tintColor = UIColor.darkGray
        self.postCommentButton.backgroundColor = UIColor.gray
        
        DBProvider.instance.newsFeedRef.child(postId).observe(.value) { (snapshot: DataSnapshot) in
            if let dict = snapshot.value as? NSDictionary {
                self.photoUrl = dict["photoUrl"] as! String
                self.likesCount = dict["likes"] as! NSNumber
                self.dislikesCount = dict["dislikes"] as! NSNumber
                self.postedUserId = dict["userid"] as! String
                self.NewsDetailedVCDateAndLocation.text = dict["newsLocation"] as? String
                self.NewsDetailedVCImageCourtesy.text = dict["photoCourtesy"] as? String
                let time = dict["timestamp"] as! Double
                self.postedDate = CommonUtils.convertServerValueTimestampToFullDate(serverTimestamp:time)
                //self.postedDate = self.postedDateFormat(time:time/1000)
                self.NewsDetailedVCDateAndLocation.text = self.NewsDetailedVCDateAndLocation.text! + " - " + self.postedDate
                self.NewsDetailedVCNewsContent.text = dict["newsContent"] as? String
            }
        }
        checkCurrentUserComments()
        getCommentsCount()
        
    }
    
    func fetchProfileImageURL(comment:PostComment){
        DBProvider.instance.userRef.child(comment.userId).observeSingleEvent(of: DataEventType.value){
            (snapShot:DataSnapshot) in
            comment.profileImageUrl = ((snapShot.value as! NSDictionary)["ProfileImageURL"] as? String)!
            print("profileImageUrl in fetchProfileImageURL: \(comment.profileImageUrl)")
            self.comments.append(comment)
            print("self.comments: \(self.comments)")
            
        }
    }
    
    func fetchProfileImageURLusingUserID(userID: String) -> String {
        var profileImageUrl = ""
        print("userID passed: \(userID)")
        //Database.database().reference().child("users").child(userID).observeSingleEvent(of: DataEventType.value) { (snapshot: DataSnapshot) in
        DBProvider.instance.userRef.child(userID).observeSingleEvent(of: DataEventType.value){
            (snapShot:DataSnapshot) in
            profileImageUrl = ((snapShot.value as! NSDictionary)["ProfileImageURL"] as? String)!
            //if let profileDict = snapShot.value as? [String: Any] {
            //   profileImageUrl = profileDict["ProfileImageURL"] as! String
            
            print("profileImageUrl in fetchProfileImageURLusingUserID: \(profileImageUrl)")
            //}
        }
        /*DBProvider.instance.userRef.child(userID).observeSingleEvent(of: DataEventType.value){
         (snapshot: DataSnapshot) in
         if let profileDict = snapshot.value as? [String: Any] {
         profileImageUrl = profileDict["ProfileImageURL"] as! String
         print("profileImageUrl in fetchProfileImageURLusingUserID: \(profileImageUrl)")
         }
         //let profileImageUrl = ((snapShot.value as! NSDictionary)["ProfileImageURL"] as? String)!
         }*/
        return profileImageUrl
    }
    
    //    override func viewWillAppear(_ animated: Bool) {
    //        super.viewWillAppear(true)
    //        if(self.writeComment.hasText == true){
    //            self.postCommentButton.isEnabled = true
    //            self.postCommentButton.tintColor = UIColor.white
    //            self.postCommentButton.backgroundColor = UIColor.blue
    //        }
    //        else{
    //            self.postCommentButton.isEnabled = false
    //            self.postCommentButton.tintColor = UIColor.darkGray
    //            self.postCommentButton.backgroundColor = UIColor.gray
    //        }
    //    }
    
    func textViewDidBeginEditing(_ textView: UITextView) {
        
        if writeComment.textColor == UIColor.lightGray {
            writeComment.text = ""
            writeComment.textColor = UIColor.black
        }
    }
    
    func textViewDidChange(_ textView: UITextView) {
        guard let commentsEntered = writeComment.text, !commentsEntered.isEmpty else {
            self.postCommentButton.isEnabled = false
            self.postCommentButton.tintColor = UIColor.darkGray
            self.postCommentButton.backgroundColor = UIColor.gray
            return
        }
        self.postCommentButton.isEnabled = true
        self.postCommentButton.tintColor = UIColor.white
        self.postCommentButton.backgroundColor = UIColor.blue
    }
    
    func textViewDidEndEditing(_ textView: UITextView) {
        
        if writeComment.text == "" {
            writeComment.text = "Add a comment"
            writeComment.textColor = UIColor.lightGray
        }
    }
    
    func loadComments(){
        DBProvider.instance.newsFeedRef.child(postId).child("usercomments").queryOrdered(byChild: "type").queryEqual(toValue: "").observe(.childAdded) { (commentSnapshot: DataSnapshot) in
            
            if let commentDict = commentSnapshot.value as? [String: Any] {
                let userIdString = commentDict["userId"] as! String
                //print("userIdString: \(userIdString)")
                let typeString = commentDict["type"] as! String
                let commentsString = commentDict["comments"] as! String
                print("commentsString: \(commentsString)")
                let commentDateDouble = commentDict["commentTimestamp"] as! Double
                //print("commentDateDouble: \(commentDateDouble)")
                let profileImageURLString = self.fetchProfileImageURLusingUserID(userID: userIdString)
                print("profileImageURLString: \(profileImageURLString)")
                let comment = PostComment(profileImageUrl: profileImageURLString, userId: userIdString, type: typeString, comments: commentsString, commentDate: commentDateDouble)
                
                //let comment = PostComment(profileImageUrl: "", userId: userIdString, type: typeString, comments: commentsString, commentDate: commentDateDouble)
                //self.fetchProfileImageURL(comment:comment)
                
                print("comment: \(comment)")
                self.comments.append(comment)
                print("self.comments: \(self.comments)")
                //self.tableView.reloadData()
            }
        }
    }
    
    func insertPostedCommentInTable(comment:PostComment){
        DBProvider.instance.userRef.child(comment.userId).observeSingleEvent(of: DataEventType.value){
            (snapShot:DataSnapshot) in
            comment.profileImageUrl = ((snapShot.value as! NSDictionary)["ProfileImageURL"] as? String)!
            print("profileImageUrl in fetchProfileImageURL: \(comment.profileImageUrl)")
            self.comments.append(comment)
            let indexPath = IndexPath (row: self.comments.count - 1,section:0)
            print("indexpath: \(indexPath)")
            self.tableView.beginUpdates()
            self.tableView.insertRows(at: [indexPath], with: .automatic)
            self.tableView.endUpdates()
            //self.tableView.reloadRows(at: [indexPath], with: .automatic)
            print("self.comments: \(self.comments)")
            
        }
    }
    
    
    @IBAction func postCommentAction(_ sender: Any) {
        //postCommentButton.isEnabled = false
        ProgressHUD.show("", interaction: true)
        let commentTimestamp = NSDate().timeIntervalSince1970
        
        let postRef = DBProvider.instance.newsFeedRef.child(postId)
        let commentsRef =  postRef.child("usercomments").child(postRef.childByAutoId().key)
        commentsRef.setValue(["userId": AVAuthService.getCurrentUserId(),"type": "", "comments": writeComment.text as String, "commentTimestamp": commentTimestamp], withCompletionBlock:{(error, ref) in
            if error != nil{
                ProgressHUD.showError(error!.localizedDescription)
                return
            }
            
            //commentDateDouble = commentTimestamp as Double
            //let comment = PostComment(profileImageUrl: "", userId: AVAuthService.getCurrentUserId(), type: "", comments: self.writeComment.text, commentDate: Double(commentTimestamp as! NSNumber))
            //self.fetchProfileImageURL(comment: comment)
            
            let commentHeight = CommonUtils.heightForView(text: self.writeComment.text, font: UIFont(name: "Verdana", size: 13)!,width: self.tableView.frame.width-60)
            //let height = commentHeight < 40 ? 40 : commentHeight
            let height = commentHeight
            self.tableView.contentSize = CGSize(width: self.view.frame.size.width, height:self.tableView.contentSize.height + height + 40)
            self.scrollView.contentSize = CGSize(width: self.view.frame.size.width, height:self.scrollView.contentSize.height + height + 40)
            let comment = PostComment(profileImageUrl: "", userId: AVAuthService.getCurrentUserId(), type: "", comments: self.writeComment.text, commentDate: commentTimestamp)
            self.writeComment.text = ""
            self.textViewDidChange(self.writeComment)
            self.textViewDidEndEditing(self.writeComment)
            
            self.getCommentsCount()
            //self.comments.removeAll()
            //self.checkCurrentUserComments()
            //self.loadComments()
            
            self.insertPostedCommentInTable(comment:comment)
            
            //self.postCommentButton.isEnabled = false
            //self.tableView.reloadData()
            ProgressHUD.dismiss()
        })
        
    }
    
    @IBAction func likesAction(_ sender: Any) {
        let postRef = DBProvider.instance.newsFeedRef.child(postId)
        if self.likesCount.intValue > 0
        {
            if userAlreadyLiked == true
            {
                postRef.child("usercomments").queryOrdered(byChild: "type").queryEqual(toValue: "Like").observeSingleEvent(of: DataEventType.value){
                    (snapShot:DataSnapshot) in
                    if let mycomments = snapShot.value as? NSDictionary{
                        for(key,value) in mycomments{
                            if let commentDic = value as? NSDictionary{
                                let userId = commentDic["userId"] as? String
                                if userId == self.currentUserid{
                                    postRef.child("usercomments").child(key as! String).removeValue()
                                    self.userAlreadyLiked = false
                                    self.likeButton.tintColor = UIColor.gray
                                    let likecount = self.likesCount.intValue - 1
                                    let value = likecount as NSNumber
                                    self.likesCount = value
                                    self.updateCountInPost()
                                    break
                                }
                                else{
                                    
                                }
                            }
                        }
                    }
                }
            }
            else{
                let commentsRef =  postRef.child("usercomments").child(postRef.childByAutoId().key)
                commentsRef.setValue(["type": "Like", "userId": self.currentUserid,
                                      "comments": ""], withCompletionBlock:{(error, ref) in
                                        if error != nil{
                                            ProgressHUD.showError(error!.localizedDescription)
                                            return
                                        }
                })
                self.likeButton.tintColor = UIColor.blue
                self.userAlreadyLiked = true
                let likecount = self.likesCount.intValue + 1
                let value = likecount as NSNumber
                self.likesCount = value
                self.updateCountInPost()
                
                if self.dislikesCount.intValue > 0 {
                    if self.userAlreadyDisliked == true {
                        
                        postRef.child("usercomments").queryOrdered(byChild: "type").queryEqual(toValue: "Dislike").observeSingleEvent(of: DataEventType.value){
                            (snapShot:DataSnapshot) in
                            if let mycomments = snapShot.value as? NSDictionary{
                                for(key,value) in mycomments{
                                    if let commentDic = value as? NSDictionary{
                                        let userId = commentDic["userId"] as? String
                                        if userId == self.currentUserid{
                                            postRef.child("usercomments").child(key as! String).removeValue()
                                            self.userAlreadyDisliked = false
                                            self.dislikeButton.tintColor = UIColor.gray
                                            let dislikecount = self.dislikesCount.intValue - 1
                                            let value = dislikecount as NSNumber
                                            self.dislikesCount = value
                                            self.updateCountInPost()
                                            break
                                        }
                                        else{
                                            
                                        }
                                    }
                                }
                            }
                        }
                    }
                    else{
                        print("userAlreadyDisliked false. do nothing.")
                    }
                }
                else{
                    print("dislikeCount = 0. do nothing")
                }
            }
        }
        else
        {
            let commentsRef =  postRef.child("usercomments").child(postRef.childByAutoId().key)
            commentsRef.setValue(["type": "Like", "userId": self.currentUserid,
                                  "comments": ""], withCompletionBlock:{(error, ref) in
                                    if error != nil{
                                        ProgressHUD.showError(error!.localizedDescription)
                                        return
                                    }
            })
            self.userAlreadyLiked = true
            self.likeButton.tintColor = UIColor.blue
            let likecount = self.likesCount.intValue + 1
            let value = likecount as NSNumber
            self.likesCount = value
            self.updateCountInPost()
            
            if self.dislikesCount.intValue > 0 {
                if self.userAlreadyDisliked == true {
                    postRef.child("usercomments").queryOrdered(byChild: "type").queryEqual(toValue: "Dislike").observeSingleEvent(of: DataEventType.value){
                        (snapShot:DataSnapshot) in
                        if let mycomments = snapShot.value as? NSDictionary{
                            for(key,value) in mycomments{
                                if let commentDic = value as? NSDictionary{
                                    let userId = commentDic["userId"] as? String
                                    if userId == self.currentUserid{
                                        postRef.child("usercomments").child(key as! String).removeValue()
                                        self.userAlreadyDisliked = false
                                        self.dislikeButton.tintColor = UIColor.gray
                                        let dislikecount = self.dislikesCount.intValue - 1
                                        let value = dislikecount as NSNumber
                                        self.dislikesCount = value
                                        self.updateCountInPost()
                                        break
                                    }
                                    else{
                                        
                                    }
                                }
                            }
                        }
                    }
                }
                else{
                    print("userAlreadyDisliked false. do nothing.")
                }
            }
            else{
                print("dislikeCount = 0. do nothing")
            }
        }
    }
    
    @IBAction func dislikeAction(_ sender: Any){
        let postRef = DBProvider.instance.newsFeedRef.child(postId)
        if self.dislikesCount.intValue > 0
        {
            if userAlreadyDisliked == true
            {
                postRef.child("usercomments").queryOrdered(byChild: "type").queryEqual(toValue: "Dislike").observeSingleEvent(of: DataEventType.value){
                    (snapShot:DataSnapshot) in
                    if let mycomments = snapShot.value as? NSDictionary{
                        for(key,value) in mycomments{
                            if let commentDic = value as? NSDictionary{
                                let userId = commentDic["userId"] as? String
                                if userId == self.currentUserid{
                                    postRef.child("usercomments").child(key as! String).removeValue()
                                    self.userAlreadyDisliked = false
                                    self.dislikeButton.tintColor = UIColor.gray
                                    let dislikecount = self.dislikesCount.intValue - 1
                                    let value = dislikecount as NSNumber
                                    self.dislikesCount = value
                                    self.updateCountInPost()
                                    break
                                }
                                else{
                                    
                                }
                            }
                        }
                    }
                }
            }
            else{
                let commentsRef =  postRef.child("usercomments").child(postRef.childByAutoId().key)
                commentsRef.setValue(["type": "Dislike", "userId": self.currentUserid,
                                      "comments": ""], withCompletionBlock:{(error, ref) in
                                        if error != nil{
                                            ProgressHUD.showError(error!.localizedDescription)
                                            return
                                        }
                                        
                })
                self.dislikeButton.tintColor = UIColor.red
                self.userAlreadyDisliked = true
                let dislikecount = self.dislikesCount.intValue + 1
                let value = dislikecount as NSNumber
                self.dislikesCount = value
                self.updateCountInPost()
                
                if self.likesCount.intValue > 0 {
                    if self.userAlreadyLiked == true {
                        postRef.child("usercomments").queryOrdered(byChild: "type").queryEqual(toValue: "Like").observeSingleEvent(of: DataEventType.value){
                            (snapShot:DataSnapshot) in
                            if let mycomments = snapShot.value as? NSDictionary{
                                for(key,value) in mycomments{
                                    if let commentDic = value as? NSDictionary{
                                        let userId = commentDic["userId"] as? String
                                        if userId == self.currentUserid{
                                            postRef.child("usercomments").child(key as! String).removeValue()
                                            self.userAlreadyLiked = false
                                            self.likeButton.tintColor = UIColor.gray
                                            let likecount = self.likesCount.intValue - 1
                                            let value = likecount as NSNumber
                                            self.likesCount = value
                                            self.updateCountInPost()
                                            break
                                        }
                                        else{
                                            
                                        }
                                    }
                                }
                            }
                        }
                    }
                    else{
                        print("userAlreadyDisliked false. do nothing.")
                    }
                }
                else{
                    print("likeCount = 0. do nothing")
                }
            }
        }
        else
        {
            let commentsRef =  postRef.child("usercomments").child(postRef.childByAutoId().key)
            commentsRef.setValue(["type": "Dislike", "userId": self.currentUserid,
                                  "comments": ""], withCompletionBlock:{(error, ref) in
                                    if error != nil{
                                        ProgressHUD.showError(error!.localizedDescription)
                                        return
                                    }
            })
            self.userAlreadyDisliked = true
            self.dislikeButton.tintColor = UIColor.red
            let dislikecount = self.dislikesCount.intValue + 1
            let value = dislikecount as NSNumber
            self.dislikesCount = value
            self.updateCountInPost()
            
            if self.likesCount.intValue > 0 {
                if self.userAlreadyLiked == true {
                    postRef.child("usercomments").queryOrdered(byChild: "type").queryEqual(toValue: "Like").observeSingleEvent(of: DataEventType.value){
                        (snapShot:DataSnapshot) in
                        if let mycomments = snapShot.value as? NSDictionary{
                            for(key,value) in mycomments{
                                if let commentDic = value as? NSDictionary{
                                    let userId = commentDic["userId"] as? String
                                    if userId == self.currentUserid{
                                        postRef.child("usercomments").child(key as! String).removeValue()
                                        self.userAlreadyLiked = false
                                        self.likeButton.tintColor = UIColor.gray
                                        let likecount = self.likesCount.intValue - 1
                                        let value = likecount as NSNumber
                                        self.likesCount = value
                                        self.updateCountInPost()
                                        break
                                    }
                                    else{
                                        
                                    }
                                }
                            }
                        }
                    }
                }
                else{
                    print("userAlreadyDisliked false. do nothing.")
                }
            }
            else{
                print("likeCount = 0. do nothing")
            }
        }
    }
    
    func toggleLikeDislike() {
        if likeToggle == true {
            //likeButton.isEnabled = false
            //dislikeButton.isEnabled = true
            
            likeButton.tintColor = UIColor.gray
            dislikeButton.tintColor = UIColor.darkGray
        }else{
            //likeButton.isEnabled = true
            //dislikeButton.isEnabled = false
            
            likeButton.tintColor = UIColor.darkGray
            dislikeButton.tintColor = UIColor.gray
        }
    }
    
    func updateCountInPost(){
        self.dislikeLabel.text = dislikesCount.stringValue
        self.likeLabel.text = likesCount.stringValue
        let ref = DBProvider.instance.newsFeedRef.child(postId)
        ref.updateChildValues(["likes": likesCount])
        ref.updateChildValues(["dislikes": dislikesCount])
    }
    
    func calculateHeight(text:String) -> CGFloat {
        //let attributes: [NSAttributedStringKey : Any] = [NSAttributedStringKey.font : UIFont.systemFont(ofSize: 15.0)]
        let attributes: [NSAttributedStringKey : Any] = [NSAttributedStringKey.font : UIFont(name: "Verdana", size: 15)!]
        //Add AvalinNext Regular
        let approximateWidth = self.scrollView.frame.width - 10
        let size = CGSize(width: approximateWidth, height:10000)
        let estimatedSize = NSString(string: text).boundingRect(with: size, options: .usesLineFragmentOrigin, attributes: attributes, context: nil)
        let height = estimatedSize.height
        return height
    }
    
    func getCommentsCount(){
        DBProvider.instance.newsFeedRef.child(postId).child("usercomments").queryOrdered(byChild: "type").queryEqual(toValue: "").observeSingleEvent(of: DataEventType.value){
            (snapShot:DataSnapshot) in
            self.writeCommentLabel.text = String(snapShot.childrenCount) + " Comments"
        }
    }
    
    func checkCurrentUserComments(){
        
        DBProvider.instance.newsFeedRef.child(postId).child("usercomments").observeSingleEvent(of: DataEventType.value){
            (snapShot:DataSnapshot) in
            
            if let mycomments = snapShot.value as? NSDictionary{
                for(key,value) in mycomments{
                    if let commentDic = value as? NSDictionary{
                        let userId = commentDic["userId"] as? String
                        if "" == commentDic["type"] as? String {
                            let comments = commentDic["comments"] as? String
                            
                            let commentTimestamp = commentDic["commentTimestamp"] as! Double
                            
                            let comment = PostComment(profileImageUrl: "", userId: AVAuthService.getCurrentUserId(), type: "", comments: comments!, commentDate: commentTimestamp)
                            //print(snapShot.childrenCount)
                            self.fetchProfileImageURL(comment:comment)
                        }
                        
                        /*if AVAuthService.getCurrentUserId() == userId {
                         self.commentKey = (key as? String)!
                         let type = commentDic["type"] as? String
                         if type == "Like" {
                         self.likeToggle = true
                         self.toggleLikeDislike()
                         }else if type == "Dislike" {
                         self.likeToggle = false
                         self.toggleLikeDislike()
                         }else{
                         NSLog("general user comments")
                         }
                         
                         }*/
                    }
                }
            }
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func postedDateFormat(time:Double) -> String{
        let postDate = CommonUtils.convertFromTimestamp(seconds: time)
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MM-dd-yyyy"
        let postDateDate = dateFormatter.date(from: postDate)
        
        let dateFormatter2 = DateFormatter()
        dateFormatter2.dateFormat = "EEEE, MMM dd, yyyy. h:mm a"
        let currentDateString: String = dateFormatter2.string(from: postDateDate!)
        return currentDateString
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if scrollView == self.scrollView{
            // scrollView.contentOffset.y = scrollView.contentOffset.y + tableView.frame.height
            //print("scrollview")
        }
        else if scrollView == self.tableView{
            //print("tableview")
        }
        
        
    }
}

extension NewsDetailedViewController:UITableViewDataSource,UITableViewDelegate{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        //print("comments count: \(comments.count)")
        return comments.count
    }
    
    // Set the spacing between sections
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 10
    }
    
    // Make the background color show through
    /*func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
     let headerView = UIView()
     headerView.backgroundColor = UIColor.clear
     return headerView
     }*/
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "CommentsTableCell") as! CommentsTableCell
        
        //print("profileimageurl in tableview indexpath function: \(comments[indexPath.row].profileImageUrl)")
        let url = comments[indexPath.row].profileImageUrl as String
        cell.profileImageView.loadImageUsingCache(urlStr: url)
        cell.comment.text = comments[indexPath.row].comments as String
        let commentedUserId = comments[indexPath.row].userId as String
        var commentedUserName = String()
        DBProvider.instance.userRef.child(commentedUserId).observe(.value) { (snapshot) in
            let commentedUserFirstName = (snapshot.value as! NSDictionary)["FirstName"] as? String
            let commentedUserLastName = (snapshot.value as! NSDictionary)["LastName"] as? String
            commentedUserName = commentedUserFirstName! + " " + commentedUserLastName!
            
            let commentAtRow = self.comments[indexPath.row].comments as String
            //self.commentedDate = self.postedDateFormat(time:time/1000)
            //cell.commentedDate.text = comments[indexPath.row].commentDate as? String
            //cell.commentedDate.topAnchor.constraint(equalTo: self.top, constant:)
            let hgt = CommonUtils.heightForView(text: commentAtRow, font:UIFont(name: "Verdana", size: 13)! ,width: UIScreen.main.bounds.width - 60)
            //let height = hgt < 40 ? 40: ceil(hgt)
            let height = ceil(hgt)
            let heightConstraint = NSLayoutConstraint(item: cell.commentedDate, attribute: NSLayoutAttribute.top, relatedBy: NSLayoutRelation.equal, toItem: cell, attribute: NSLayoutAttribute.top, multiplier: 1, constant: (height+10))
            
            cell.addConstraint(heightConstraint)
            //let commentedDateString = self.postedDateFormat(time: (comments[indexPath.row].commentDate)/1000)
            let commentedTimestamp = (self.comments[indexPath.row].commentDate)
            let currentTimestamp = NSDate().timeIntervalSince1970
            
            let duration = currentTimestamp - commentedTimestamp
            var commentString = ""
            let minutes = Int(duration/60)
            let hours = Int(duration/3600)
            let days = Int(duration/86400)
            let months = Int(duration/2592000)
            let years = Int(duration/31104000)
            if duration < 60 {
                commentString = "\(commentedUserName) 𐄁 few seconds ago"
            }
            else if duration < 300 {
                commentString = "\(commentedUserName) 𐄁 few minutes ago"
            }
            else if duration < 3600 {
                if minutes < 2{
                    commentString = "\(commentedUserName) 𐄁 \(minutes) minute ago"
                }else if minutes >= 2 {
                    commentString = "\(commentedUserName) 𐄁 \(minutes) minutes ago"
                }
            }
            else if duration < 86400 {
                if hours < 2 {
                    commentString = "\(commentedUserName) 𐄁 \(hours) hour ago"
                }else if hours >= 2 {
                    commentString = "\(commentedUserName) 𐄁 \(hours) hours ago"
                }
            }
            else if duration < 2592000 {
                if days < 2 {
                    commentString = "\(commentedUserName) 𐄁 \(days) day ago"
                }else if days >= 2 {
                    commentString = "\(commentedUserName) 𐄁 \(days) days ago"
                }
            }
            else if duration < 31104000 {
                if months < 2 {
                    if days >= 45 {
                        commentString = "\(commentedUserName) 𐄁 \(days) days ago"
                    } else if days < 45 {
                        commentString = "\(commentedUserName) 𐄁 \(months) month ago"
                    }
                }else if months >= 2 {
                    commentString = "\(commentedUserName) 𐄁 \(months) months ago"
                }
            }
            else if duration > 31104000 {
                if years < 2 {
                    commentString = "\(commentedUserName) 𐄁 \(years) year ago"
                }else if years >= 2 {
                    commentString = "\(commentedUserName) 𐄁 \(years) years ago"
                }
            }
            else{
                commentString = "\(commentedUserName) 𐄁 long time back"
            }
            
            cell.commentedDate.text = "\(commentString)"
        }
        
        cell.commentedDate.font = UIFont(name: "Verdana", size: 12)
        cell.commentedDate.textColor = UIColor.gray
        return cell
    }
    
    func tableView(_ tableView: UITableView,heightForRowAt indexPath: IndexPath) -> CGFloat{
        //removed CommonUtils.calculateHeight
        let estimatedHgt = CommonUtils.heightForView(text: comments[indexPath.row].comments, font: UIFont(name: "Verdana", size: 13)!,width: UIScreen.main.bounds.width - 60 /*self.tableView.layer.frame.width-60*/)
        //let height = estimatedHgt < 40 ? 40 : ceil(estimatedHgt)
        let height = ceil(estimatedHgt)
        return height + 40
    }
    
}


