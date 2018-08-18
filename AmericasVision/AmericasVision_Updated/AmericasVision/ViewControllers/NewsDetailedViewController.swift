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

class NewsDetailedViewController: UIViewController,UIScrollViewDelegate {
    
    var NewsDetailedVCImage : UIImageView = {
        let view = UIImageView()
        view.translatesAutoresizingMaskIntoConstraints = false
        let image = UIImage(named: "profile")
        view.image = image
        return view
    }()
    
    let NewsDetailedVCImageCourtesy: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        label.sizeToFit()
        label.font = UIFont.boldSystemFont(ofSize: 13)
        label.textAlignment = .justified
        label.backgroundColor = UIColor.groupTableViewBackground
        return label
    }()
    
    let NewsDetailedVCNewsContent: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        label.sizeToFit()
        label.font = UIFont.systemFont(ofSize: 15)
        label.textAlignment = .justified
        label.backgroundColor = UIColor.groupTableViewBackground
        return label
    }()
    
    var likesCount: NSNumber = 0
    
    var dislikesCount: NSNumber = 0
    
    let postedBy: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        label.sizeToFit()
        label.font = UIFont.boldSystemFont(ofSize: 13)
        label.textAlignment = .justified
        label.backgroundColor = UIColor.groupTableViewBackground
        return label
    }()
    
    let likeButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setImage(UIImage(named: "like"), for: .normal)
        return button
    }()
    
    let dislikeButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setImage(UIImage(named: "dislike"), for: .normal)
        return button
    }()
    
    let oldCommentsLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        label.sizeToFit()
        label.text = "User Comments"
        label.font = UIFont.boldSystemFont(ofSize: 15)
        label.textAlignment = .justified
        label.backgroundColor = UIColor.groupTableViewBackground
        return label
    }()
    
    let writeCommentLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Write Comments"
        label.numberOfLines = 0
        label.sizeToFit()
        label.font = UIFont.boldSystemFont(ofSize: 13)
        label.textAlignment = .justified
        label.backgroundColor = UIColor.groupTableViewBackground
        return label
    }()
    
    let writeComment: UITextView = {
        let writeComment = UITextView()
        writeComment.translatesAutoresizingMaskIntoConstraints = false
        writeComment.layer.borderColor = UIColor.lightGray.cgColor
        writeComment.layer.borderWidth = 1.0;
        writeComment.layer.cornerRadius = 5.0;
        writeComment.font = UIFont.boldSystemFont(ofSize: 15)
        return writeComment
    }()
    
    let oldComments: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        label.sizeToFit()
        label.font = UIFont.boldSystemFont(ofSize: 13)
        label.textAlignment = .justified
        label.backgroundColor = UIColor.groupTableViewBackground
        label.layer.borderColor = UIColor.lightGray.cgColor
        label.layer.borderWidth = 1.0;
        label.layer.cornerRadius = 5.0;
        return label
    }()
    
    let NewsDetailedVCImageCaption: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        label.sizeToFit()
        label.font = UIFont.boldSystemFont(ofSize: 13)
        label.textAlignment = .justified
        label.backgroundColor = UIColor.groupTableViewBackground
        return label
    }()
    
    let likeLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        label.sizeToFit()
        label.font = UIFont.boldSystemFont(ofSize: 13)
        label.textAlignment = .justified
        label.backgroundColor = UIColor.groupTableViewBackground
        return label
    }()
    
    let dislikeLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        label.sizeToFit()
        label.font = UIFont.boldSystemFont(ofSize: 13)
        label.textAlignment = .justified
        label.backgroundColor = UIColor.groupTableViewBackground
        return label
    }()

    var postId = String()
    var postedUserId = String()
    var likeToggle: Bool = false
    var getPostedBy = String()
    var username = String()
    var postedDate = String()
    var photoUrl = String()
    
    var commentKey = "-LIaLIBaIl1zYD9f-Kqn"
    
    
    @IBOutlet weak var scrollView: UIScrollView!
    
    override func viewDidAppear(_ animated: Bool) {
       DBProvider.instance.userRef.child(postedUserId).observe(.value) { (snapshot) in
                let userFirstName = (snapshot.value as! NSDictionary)["FirstName"] as? String
                let userLastName = (snapshot.value as! NSDictionary)["LastName"] as? String
                self.postedBy.text = "Posted By: " + userFirstName! + ", " + userLastName!
            }
    
        NewsDetailedVCImage.topAnchor.constraint(equalTo: scrollView.topAnchor, constant:1).isActive = true
        // NewsDetailedVCImage.leftAnchor.constraint(equalTo: scrollView.leftAnchor, constant:0).isActive = true
        // NewsDetailedVCImage.rightAnchor.constraint(equalTo: scrollView.rightAnchor, constant:0).isActive = true
        NewsDetailedVCImage.heightAnchor.constraint(equalToConstant:300).isActive = true
        NewsDetailedVCImage.widthAnchor.constraint(equalToConstant:self.view.frame.width).isActive = true
        
        // NewsDetailedVCImageCourtesy.leftAnchor.constraint(equalTo: scrollView.leftAnchor, constant:0).isActive = true
        NewsDetailedVCImageCourtesy.topAnchor.constraint(equalTo: scrollView.topAnchor, constant:300).isActive = true
        // NewsDetailedVCImageCourtesy.rightAnchor.constraint(equalTo: scrollView.rightAnchor, constant:0).isActive = true
        NewsDetailedVCImageCourtesy.heightAnchor.constraint(equalToConstant:20).isActive = true
        NewsDetailedVCImageCourtesy.widthAnchor.constraint(equalToConstant:self.view.frame.width/2).isActive = true
        
        postedBy.topAnchor.constraint(equalTo: scrollView.topAnchor, constant:300).isActive = true
        postedBy.leftAnchor.constraint(equalTo: scrollView.rightAnchor, constant:self.view.frame.width/2).isActive = true
        postedBy.heightAnchor.constraint(equalToConstant:20).isActive = true
        postedBy.widthAnchor.constraint(equalToConstant:self.view.frame.width/2).isActive = true
        //
        //   NewsDetailedVCImageCaption.leftAnchor.constraint(equalTo: scrollView.leftAnchor, constant:0).isActive = true
        NewsDetailedVCImageCaption.topAnchor.constraint(equalTo: scrollView.topAnchor, constant:320).isActive = true
        //   NewsDetailedVCImageCaption.rightAnchor.constraint(equalTo: scrollView.rightAnchor, constant:0).isActive = true
        NewsDetailedVCImageCaption.heightAnchor.constraint(equalToConstant:20).isActive = true
        NewsDetailedVCImageCaption.widthAnchor.constraint(equalToConstant:self.view.frame.width).isActive = true
        
        likeButton.topAnchor.constraint(equalTo: scrollView.topAnchor, constant:320).isActive = true
        likeButton.leftAnchor.constraint(equalTo: scrollView.leftAnchor, constant:self.view.frame.width/2).isActive = true
        likeButton.heightAnchor.constraint(equalToConstant:20).isActive = true
        
        likeLabel.topAnchor.constraint(equalTo: scrollView.topAnchor, constant:320).isActive = true
        likeLabel.leftAnchor.constraint(equalTo: scrollView.leftAnchor, constant:self.view.frame.width/2 + 30).isActive = true
        likeLabel.heightAnchor.constraint(equalToConstant:20).isActive = true
        
        dislikeButton.topAnchor.constraint(equalTo: scrollView.topAnchor, constant:320).isActive = true
        dislikeButton.leftAnchor.constraint(equalTo: scrollView.leftAnchor, constant:self.view.frame.width/2 + 60).isActive = true
        dislikeButton.heightAnchor.constraint(equalToConstant:20).isActive = true
        
        dislikeLabel.topAnchor.constraint(equalTo: scrollView.topAnchor, constant:320).isActive = true
        dislikeLabel.leftAnchor.constraint(equalTo: scrollView.leftAnchor, constant:self.view.frame.width/2 + 90).isActive = true
        dislikeLabel.heightAnchor.constraint(equalToConstant:20).isActive = true
        
        // NewsDetailedVCNewsContent.leftAnchor.constraint(equalTo: scrollView.leftAnchor, constant:0).isActive = true
        NewsDetailedVCNewsContent.topAnchor.constraint(equalTo: scrollView.topAnchor, constant:340).isActive = true
        //  NewsDetailedVCNewsContent.rightAnchor.constraint(equalTo: scrollView.rightAnchor, constant:0).isActive = true
        let contentHeight = calculateHeight()
        NewsDetailedVCNewsContent.heightAnchor.constraint(equalToConstant:contentHeight).isActive = true
        NewsDetailedVCNewsContent.widthAnchor.constraint(equalToConstant:self.view.frame.width).isActive = true
        
        // writeCommentLabel.leftAnchor.constraint(equalTo: scrollView.leftAnchor, constant:0).isActive = true
        // writeCommentLabel.rightAnchor.constraint(equalTo: scrollView.rightAnchor, constant:0).isActive = true
        
        writeCommentLabel.topAnchor.constraint(equalTo:scrollView.topAnchor, constant: 340 + contentHeight).isActive = true
        writeCommentLabel.heightAnchor.constraint(equalToConstant:20).isActive = true
        writeCommentLabel.widthAnchor.constraint(equalToConstant:self.view.frame.width).isActive = true
        
        // writeComment.leftAnchor.constraint(equalTo: scrollView.leftAnchor, constant:0).isActive = true
        writeComment.topAnchor.constraint(equalTo: scrollView.topAnchor, constant:360 + contentHeight).isActive = true
        // writeComment.rightAnchor.constraint(equalTo: scrollView.rightAnchor, constant:0).isActive = true
        writeComment.heightAnchor.constraint(equalToConstant:50).isActive = true
        writeComment.widthAnchor.constraint(equalToConstant:self.view.frame.width).isActive = true
        
        //  oldCommentsLabel.leftAnchor.constraint(equalTo: view.leftAnchor, constant:0).isActive = true
        oldCommentsLabel.topAnchor.constraint(equalTo: scrollView.topAnchor, constant:410 + contentHeight).isActive = true
        //  oldCommentsLabel.rightAnchor.constraint(equalTo: scrollView.rightAnchor, constant:0).isActive = true
        oldCommentsLabel.heightAnchor.constraint(equalToConstant:20).isActive = true
        oldCommentsLabel.widthAnchor.constraint(equalToConstant:self.view.frame.width).isActive = true
        
        //  oldComments.leftAnchor.constraint(equalTo: scrollView.leftAnchor, constant:0).isActive = true
        oldComments.topAnchor.constraint(equalTo: scrollView.topAnchor, constant:430 + contentHeight).isActive = true
        //  oldComments.rightAnchor.constraint(equalTo: view.rightAnchor, constant:0).isActive = true
        oldComments.heightAnchor.constraint(equalToConstant:130).isActive = true
        oldComments.widthAnchor.constraint(equalToConstant:self.view.frame.width).isActive = true
        
        likeLabel.text = likesCount.stringValue
        dislikeLabel.text = dislikesCount.stringValue
        
        self.scrollView.isScrollEnabled = true
        scrollView.contentSize = CGSize(width: self.view.frame.size.width, height:560 + contentHeight)
        
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
        
        
        //checkCurrentUserComments()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        self.scrollView.addSubview(NewsDetailedVCImage)
        self.scrollView.addSubview(NewsDetailedVCImageCourtesy)
        self.scrollView.addSubview(postedBy)
        self.scrollView.addSubview(NewsDetailedVCImageCaption)
        self.scrollView.addSubview(NewsDetailedVCNewsContent)
        self.scrollView.addSubview(likeButton)
        self.scrollView.addSubview(likeLabel)
        self.scrollView.addSubview(dislikeButton)
        self.scrollView.addSubview(dislikeLabel)
        self.scrollView.addSubview(writeCommentLabel)
        self.scrollView.addSubview(writeComment)
        self.scrollView.addSubview(oldCommentsLabel)
        self.scrollView.addSubview(oldComments)
        scrollView.isScrollEnabled = true
        scrollView.delegate = self
        self.navigationItem.title = "Details"
        
        DBProvider.instance.newsFeedRef.child(postId).observe(.value) { (snapshot: DataSnapshot) in
            if let dict = snapshot.value as? NSDictionary {
                self.photoUrl = dict["photoUrl"] as! String
                self.likesCount = dict["likes"] as! NSNumber
                self.dislikesCount = dict["dislikes"] as! NSNumber
                self.postedUserId = dict["userid"] as! String
                self.NewsDetailedVCImageCaption.text = dict["newsLocation"] as! String
                self.NewsDetailedVCImageCourtesy.text = dict["photoCourtesy"] as! String
                let time = dict["timestamp"] as! Double
                self.postedDate = self.postedDateFormat(time:time)
                self.NewsDetailedVCImageCaption.text = self.NewsDetailedVCImageCaption.text! + self.postedDate
                self.NewsDetailedVCNewsContent.text = dict["newsContent"] as! String
            }
        }
        
    }
    
     @IBAction func likesAction(_ sender: Any) {
        print("likes")
        let postRef = DBProvider.instance.newsFeedRef.child(postId)
        if(self.dislikesCount.intValue > 0){
            let dislikecount = self.dislikesCount.intValue - 1
            let value = dislikecount as NSNumber
            
            self.dislikesCount = value
            NSLog("remove user dislike comments and add like comment section")
            DBProvider.instance.newsFeedRef.child(postId).child("usercomments").child(commentKey).removeValue()
        }
        let commentsRef =  postRef.child("usercomments").child(postRef.childByAutoId().key)
        commentsRef.setValue(["type": "Like", "userId": AVAuthService.getCurrentUserId(),
                              "comments": ""], withCompletionBlock:{(error, ref) in
            if error != nil{
                ProgressHUD.showError(error!.localizedDescription)
                return
            }
            self.likeToggle = true
            let likecount = self.likesCount.intValue + 1
            let value = likecount as NSNumber
            self.likesCount = value
            self.toggleLikeDislike()
            self.updateCountInPost()
        })
        
    }
    
    @IBAction func dislikeAction(_ sender: Any) {
        let postRef = DBProvider.instance.newsFeedRef.child(postId)
        let userId = AVAuthService.getCurrentUserId()
        if(self.likesCount.intValue > 0){
            let likecount = self.likesCount.intValue - 1
            let value = likecount as NSNumber
            self.likesCount = value
            NSLog("remove user like comments and add dislike comment section")
            DBProvider.instance.newsFeedRef.child(postId).child("usercomments").child(commentKey).removeValue()
        }
        let commentsRef =  postRef.child("usercomments").child(postRef.childByAutoId().key)
        commentsRef.setValue(["type": "Dislike", "userId": userId ,
          "comments": ""], withCompletionBlock:{(error, ref) in
            if error != nil{
                ProgressHUD.showError(error!.localizedDescription)
                return
            }
            self.likeToggle = false
            let dislikecount = self.dislikesCount.intValue + 1
            let value = dislikecount as NSNumber
            self.dislikesCount = value
            self.toggleLikeDislike()
            self.updateCountInPost()
        })
        
    }
    
    func toggleLikeDislike() {
        if likeToggle == true {
            likeButton.isEnabled = false
            dislikeButton.isEnabled = true
        }else{
            likeButton.isEnabled = true
            dislikeButton.isEnabled = false
        }
    }
    
    func updateCountInPost(){
        let ref = DBProvider.instance.newsFeedRef.child(postId)
        ref.updateChildValues(["likes": likesCount])
        ref.updateChildValues(["dislikes": dislikesCount])
    }
    
    func calculateHeight() -> CGFloat {
        let attributes: [NSAttributedStringKey : Any] = [NSAttributedStringKey.font : UIFont.systemFont(ofSize: 15.0)]
        //Add AvalinNext Regular
        let approximateWidth = self.scrollView.frame.width - 10
        let size = CGSize(width: approximateWidth, height:10000)
        let estimatedSize = NSString(string: NewsDetailedVCNewsContent.text!).boundingRect(with: size, options: .usesLineFragmentOrigin, attributes: attributes, context: nil)
        let height = estimatedSize.height
        return height
    }
   
    func checkCurrentUserComments(){
        DBProvider.instance.newsFeedRef.child(postId).child("usercomments").observeSingleEvent(of: DataEventType.value){
            (snapShot:DataSnapshot) in
            var comments = [NSDictionary]()
            
            if let mycomments = snapShot.value as? NSDictionary{
                for(key,value) in mycomments{
                    if let commentDic = value as? NSDictionary{
                        if AVAuthService.getCurrentUserId() == commentDic["userId"] as? String {
                            self.commentKey = (key as? String)!
                            comments.append(commentDic)
                            let type = commentDic["type"] as? String
                            if type == "Like" {
                                self.likeToggle = true
                            }else{
                                self.likeToggle = false
                            }
                            self.toggleLikeDislike()
                        }
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
        let postedDate = dateFormatter.date(from: postDate)
        let currentDateString: String = dateFormatter.string(from: postedDate!)
        return currentDateString
    }
}
