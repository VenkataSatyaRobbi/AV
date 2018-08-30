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
            let label = UILabel()
            label.textColor = UIColor.black
            label.font = UIFont.systemFont(ofSize: 13)
            label.translatesAutoresizingMaskIntoConstraints = false
            label.numberOfLines = 0
            label.sizeToFit()
            label.textAlignment = .justified
            return label
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
        
        profileImageView.leftAnchor.constraint(equalTo: leftAnchor, constant:10).isActive = true
        profileImageView.heightAnchor.constraint(equalToConstant:30).isActive = true
        profileImageView.widthAnchor.constraint(equalToConstant:30).isActive = true
        
        comment.leftAnchor.constraint(equalTo: leftAnchor, constant:40).isActive = true
        //comment.heightAnchor.constraint(equalToConstant:30).isActive = true
        comment.widthAnchor.constraint(equalToConstant:self.frame.width-40).isActive = true
       
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
}

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
        label.font = UIFont.systemFont(ofSize: 13)
        label.textAlignment = .justified
        return label
    }()
    
    let NewsDetailedVCNewsContent: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        label.sizeToFit()
        label.font = UIFont.systemFont(ofSize: 15)
        label.textAlignment = .justified
        label.lineBreakMode = .byWordWrapping
        return label
    }()
    
    var likesCount: NSNumber = 0
    
    var dislikesCount: NSNumber = 0
    
    let postedBy: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        label.sizeToFit()
        label.font = UIFont.systemFont(ofSize: 13)
        label.textAlignment = .justified
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
        label.font = UIFont.boldSystemFont(ofSize: 13)
        label.textAlignment = .justified
        label.textColor = UIColor.blue
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
        label.textColor = UIColor.blue
        return label
    }()
    
    let writeComment: UITextView = {
        let writeComment = UITextView()
        writeComment.translatesAutoresizingMaskIntoConstraints = false
        writeComment.layer.borderColor = UIColor.lightGray.cgColor
        writeComment.layer.borderWidth = 1.0;
        writeComment.layer.cornerRadius = 5.0;
        writeComment.font = UIFont.boldSystemFont(ofSize: 13)
        return writeComment
    }()
    
    let oldComments: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        label.sizeToFit()
        label.font = UIFont.systemFont(ofSize: 13)
        label.textAlignment = .justified
        label.backgroundColor = UIColor.lightGray
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
        label.font = UIFont.systemFont(ofSize: 13)
        label.textAlignment = .justified
        return label
    }()
    
    let likeLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        label.sizeToFit()
        label.font = UIFont.boldSystemFont(ofSize: 13)
        label.textAlignment = .justified
        return label
    }()
    
    let dislikeLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        label.sizeToFit()
        label.font = UIFont.boldSystemFont(ofSize: 13)
        label.textAlignment = .justified
        return label
    }()
    
    let oldCommentsView: UIView = {
        let oldCommentsView = UIView()
        oldCommentsView.translatesAutoresizingMaskIntoConstraints = false
        return oldCommentsView
    }()
    
    let postCommentButton: UIButton = {
        let button = UIButton(type: UIButtonType.system)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.backgroundColor = UIColor(red: 6/255, green: 90/255, blue: 157/255, alpha: 1)
        button.layer.cornerRadius = 2.0
        button.setTitle("Post Comment", for: .normal)
        button.setTitleColor(.white, for: .normal)
        return button
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
    
    @IBOutlet weak var scrollView: UIScrollView!
    var tableView: UITableView = UITableView()
    
    override func viewDidAppear(_ animated: Bool) {
       DBProvider.instance.userRef.child(postedUserId).observe(.value) { (snapshot) in
                let userFirstName = (snapshot.value as! NSDictionary)["FirstName"] as? String
                let userLastName = (snapshot.value as! NSDictionary)["LastName"] as? String
                self.postedBy.text = "Posted By: " + userFirstName! + ", " + userLastName!
        }
        var commentsHeight:CGFloat = 0
        comments.forEach { comment in
            let approximateWidth = tableView.layer.frame.width - 50
            let hgt = CommonUtils.calculateHeight(text: comment.comments, width: approximateWidth)
            let height = hgt < 40 ? 40:hgt
            commentsHeight = commentsHeight + height
        }
    
        NewsDetailedVCImage.topAnchor.constraint(equalTo: scrollView.topAnchor, constant:1).isActive = true
        NewsDetailedVCImage.heightAnchor.constraint(equalToConstant:200).isActive = true
        NewsDetailedVCImage.widthAnchor.constraint(equalToConstant:self.view.frame.width).isActive = true
        
        NewsDetailedVCImageCourtesy.leftAnchor.constraint(equalTo: scrollView.leftAnchor, constant:5).isActive = true
        NewsDetailedVCImageCourtesy.topAnchor.constraint(equalTo: scrollView.topAnchor, constant:200).isActive = true
        NewsDetailedVCImageCourtesy.heightAnchor.constraint(equalToConstant:20).isActive = true
        NewsDetailedVCImageCourtesy.widthAnchor.constraint(equalToConstant:(self.view.frame.width/2)-5).isActive = true
        
        postedBy.topAnchor.constraint(equalTo: scrollView.topAnchor, constant:200).isActive = true
        postedBy.leftAnchor.constraint(equalTo: scrollView.rightAnchor, constant:(self.view.frame.width/2) + 40).isActive = true
        postedBy.heightAnchor.constraint(equalToConstant:20).isActive = true
        postedBy.widthAnchor.constraint(equalToConstant:(self.view.frame.width/2)-5).isActive = true
        
        NewsDetailedVCImageCaption.leftAnchor.constraint(equalTo: scrollView.leftAnchor, constant:5).isActive = true
        NewsDetailedVCImageCaption.topAnchor.constraint(equalTo: scrollView.topAnchor, constant:220).isActive = true
        NewsDetailedVCImageCaption.heightAnchor.constraint(equalToConstant:20).isActive = true
        NewsDetailedVCImageCaption.widthAnchor.constraint(equalToConstant:self.view.frame.width).isActive = true
        
        likeButton.topAnchor.constraint(equalTo: scrollView.topAnchor, constant:220).isActive = true
        likeButton.leftAnchor.constraint(equalTo: scrollView.leftAnchor, constant:(self.view.frame.width/2)+40).isActive = true
        likeButton.heightAnchor.constraint(equalToConstant:20).isActive = true
        likeButton.addTarget(self,action: #selector(self.likesAction(_:)),for: .touchUpInside)
        
        likeLabel.topAnchor.constraint(equalTo: scrollView.topAnchor, constant:220).isActive = true
        likeLabel.leftAnchor.constraint(equalTo: scrollView.leftAnchor, constant:(self.view.frame.width/2) + 65).isActive = true
        likeLabel.heightAnchor.constraint(equalToConstant:20).isActive = true
        
        dislikeButton.topAnchor.constraint(equalTo: scrollView.topAnchor, constant:220).isActive = true
        dislikeButton.leftAnchor.constraint(equalTo: scrollView.leftAnchor, constant:(self.view.frame.width/2) + 80).isActive = true
        dislikeButton.heightAnchor.constraint(equalToConstant:20).isActive = true
        dislikeButton.addTarget(self,action: #selector(self.dislikeAction(_:)),for: .touchUpInside)
        
        dislikeLabel.topAnchor.constraint(equalTo: scrollView.topAnchor, constant:220).isActive = true
        dislikeLabel.leftAnchor.constraint(equalTo: scrollView.leftAnchor, constant:(self.view.frame.width/2) + 105).isActive = true
        dislikeLabel.heightAnchor.constraint(equalToConstant:20).isActive = true
        
        NewsDetailedVCNewsContent.topAnchor.constraint(equalTo: scrollView.topAnchor, constant:240).isActive = true
        NewsDetailedVCNewsContent.leftAnchor.constraint(equalTo: scrollView.leftAnchor, constant:5).isActive = true
        let contentHeight = calculateHeight(text:NewsDetailedVCNewsContent.text!)
        NewsDetailedVCNewsContent.heightAnchor.constraint(equalToConstant:contentHeight).isActive = true
        NewsDetailedVCNewsContent.widthAnchor.constraint(equalToConstant:self.view.frame.width-10).isActive = true
        
        writeCommentLabel.leftAnchor.constraint(equalTo:scrollView.leftAnchor, constant: 5).isActive = true
        writeCommentLabel.topAnchor.constraint(equalTo:scrollView.topAnchor, constant: 240 + contentHeight).isActive = true
        writeCommentLabel.heightAnchor.constraint(equalToConstant:20).isActive = true
        writeCommentLabel.widthAnchor.constraint(equalToConstant:self.view.frame.width-10).isActive = true
        
        writeComment.leftAnchor.constraint(equalTo:scrollView.leftAnchor, constant: 5).isActive = true
        writeComment.topAnchor.constraint(equalTo: scrollView.topAnchor, constant:260 + contentHeight).isActive = true
        writeComment.heightAnchor.constraint(equalToConstant:50).isActive = true
        writeComment.widthAnchor.constraint(equalToConstant:self.view.frame.width-10).isActive = true
        
        postCommentButton.leftAnchor.constraint(equalTo:scrollView.leftAnchor, constant: 5).isActive = true
        postCommentButton.topAnchor.constraint(equalTo: scrollView.topAnchor, constant:315 + contentHeight).isActive = true
        postCommentButton.heightAnchor.constraint(equalToConstant:30).isActive = true
        postCommentButton.widthAnchor.constraint(equalToConstant:self.view.frame.width-10).isActive = true
        postCommentButton.addTarget(self,action: #selector(self.postCommentAction(_:)),for: .touchUpInside)
        
        oldCommentsLabel.leftAnchor.constraint(equalTo: scrollView.leftAnchor, constant:5).isActive = true
        oldCommentsLabel.topAnchor.constraint(equalTo: scrollView.topAnchor, constant:350 + contentHeight).isActive = true
        oldCommentsLabel.heightAnchor.constraint(equalToConstant:20).isActive = true
        oldCommentsLabel.widthAnchor.constraint(equalToConstant:self.view.frame.width-10).isActive = true
        
        likeLabel.text = likesCount.stringValue
        dislikeLabel.text = dislikesCount.stringValue
        
        if comments.count > 0 {
            let indexPath = NSIndexPath(row:comments.count-1, section: 0)
            tableView.scrollToRow(at: indexPath as IndexPath, at: .bottom, animated: false)
            tableView.frame = CGRect(x: 0, y: (370 + contentHeight), width: self.view.frame.width, height: commentsHeight)
            
            self.scrollView.addSubview(tableView)
            self.scrollView.isScrollEnabled = true
        }
        scrollView.contentSize = CGSize(width: self.view.frame.size.width, height:370 + contentHeight + commentsHeight + 10)
        // 10 height for bottom
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
        self.scrollView.addSubview(postCommentButton)
        self.scrollView.addSubview(oldCommentsLabel)
        
        tableView.register(CommentsTableCell.self, forCellReuseIdentifier: "CommentsTableCell")
        tableView.delegate = self
        tableView.dataSource = self
        tableView.bounces = false
        tableView.isScrollEnabled = true
       // self.scrollView.addSubview(tableView)
        
        scrollView.isScrollEnabled = true
        scrollView.delegate = self
        self.navigationItem.title = "Details"
        
        DBProvider.instance.newsFeedRef.child(postId).observe(.value) { (snapshot: DataSnapshot) in
            if let dict = snapshot.value as? NSDictionary {
                self.photoUrl = dict["photoUrl"] as! String
                self.likesCount = dict["likes"] as! NSNumber
                self.dislikesCount = dict["dislikes"] as! NSNumber
                self.postedUserId = dict["userid"] as! String
                self.NewsDetailedVCImageCaption.text = dict["newsLocation"] as? String
                self.NewsDetailedVCImageCourtesy.text = dict["photoCourtesy"] as? String
                let time = dict["timestamp"] as! Double
                self.postedDate = self.postedDateFormat(time:time)
                self.NewsDetailedVCImageCaption.text = self.NewsDetailedVCImageCaption.text! + self.postedDate
                self.NewsDetailedVCNewsContent.text = dict["newsContent"] as? String
            }
        }
        
        checkCurrentUserComments()
        
    }
    
    func fetchProfileImageURL(comment:PostComment){
        DBProvider.instance.userRef.child(comment.userId).observeSingleEvent(of: DataEventType.value){
                (snapShot:DataSnapshot) in
            comment.profileImageUrl = ((snapShot.value as! NSDictionary)["ProfileImageURL"] as? String)!
            self.comments.append(comment)
        }
    }
    
    
    @IBAction func postCommentAction(_ sender: Any) {
        postCommentButton.isEnabled = false
        let postRef = DBProvider.instance.newsFeedRef.child(postId)
        let commentsRef =  postRef.child("usercomments").child(postRef.childByAutoId().key)
        commentsRef.setValue(["userId": AVAuthService.getCurrentUserId(),"type": "",
          "comments": writeComment.text as String], withCompletionBlock:{(error, ref) in
            if error != nil{
                ProgressHUD.showError(error!.localizedDescription)
                return
            }
            let comment = PostComment(profileImageUrl: "", userId: AVAuthService.getCurrentUserId(), type: "", comments: self.writeComment.text, commentDate: Date())
            self.fetchProfileImageURL(comment: comment)
            
            let commentHeight = CommonUtils.calculateHeight(text: self.writeComment.text,width: self.tableView.frame.width-50)
            let height = commentHeight < 40 ? 40 : commentHeight
            self.tableView.contentSize = CGSize(width: self.view.frame.size.width, height:self.tableView.contentSize.height + height)
            self.scrollView.contentSize = CGSize(width: self.view.frame.size.width, height:self.scrollView.contentSize.height + height)
            self.writeComment.text=""
            self.postCommentButton.isEnabled = true
            self.tableView.reloadData()
        })
        
    }
    
     @IBAction func likesAction(_ sender: Any) {
        print("likes")
        let postRef = DBProvider.instance.newsFeedRef.child(postId)
        if(self.dislikesCount.intValue > 0){
            let dislikecount = self.dislikesCount.intValue - 1
            let value = dislikecount as NSNumber
            
            self.dislikesCount = value
            NSLog("remove user dislike comments and add like comment section")
            DBProvider.instance.newsFeedRef.child(postId).child("usercomments").child(commentKey).updateChildValues(["type": "Like"])
        }else{
            let commentsRef =  postRef.child("usercomments").child(postRef.childByAutoId().key)
            commentsRef.setValue(["type": "Like", "userId": AVAuthService.getCurrentUserId(),
                                  "comments": ""], withCompletionBlock:{(error, ref) in
                if error != nil{
                    ProgressHUD.showError(error!.localizedDescription)
                    return
                }
                
            })
        }
        self.likeToggle = true
        let likecount = self.likesCount.intValue + 1
        let value = likecount as NSNumber
        self.likesCount = value
        self.toggleLikeDislike()
        self.updateCountInPost()
        
    }
    
    @IBAction func dislikeAction(_ sender: Any) {
        let postRef = DBProvider.instance.newsFeedRef.child(postId)
        let userId = AVAuthService.getCurrentUserId()
        if(self.likesCount.intValue > 0){
            let likecount = self.likesCount.intValue - 1
            let value = likecount as NSNumber
            self.likesCount = value
            NSLog("remove user like comments and add dislike comment section")
            DBProvider.instance.newsFeedRef.child(postId).child("usercomments").child(commentKey).updateChildValues(["type": "Dislike"])
        }else{
            let commentsRef =  postRef.child("usercomments").child(postRef.childByAutoId().key)
            commentsRef.setValue(["type": "Dislike", "userId": userId ,
              "comments": ""], withCompletionBlock:{(error, ref) in
                if error != nil{
                    ProgressHUD.showError(error!.localizedDescription)
                    return
                }
                
            })
        }
        self.likeToggle = false
        let dislikecount = self.dislikesCount.intValue + 1
        let value = dislikecount as NSNumber
        self.dislikesCount = value
        self.toggleLikeDislike()
        self.updateCountInPost()
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
        self.dislikeLabel.text = dislikesCount.stringValue
        self.likeLabel.text = likesCount.stringValue
        let ref = DBProvider.instance.newsFeedRef.child(postId)
        ref.updateChildValues(["likes": likesCount])
        ref.updateChildValues(["dislikes": dislikesCount])
    }
    
    func calculateHeight(text:String) -> CGFloat {
        let attributes: [NSAttributedStringKey : Any] = [NSAttributedStringKey.font : UIFont.systemFont(ofSize: 15.0)]
        //Add AvalinNext Regular
        let approximateWidth = self.scrollView.frame.width - 10
        let size = CGSize(width: approximateWidth, height:10000)
        let estimatedSize = NSString(string: text).boundingRect(with: size, options: .usesLineFragmentOrigin, attributes: attributes, context: nil)
        let height = estimatedSize.height
        return height
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
                            let comment = PostComment(profileImageUrl: "", userId: AVAuthService.getCurrentUserId(), type: "", comments: comments!, commentDate: Date())
                            self.fetchProfileImageURL(comment:comment)
                        }
                        
                        if AVAuthService.getCurrentUserId() == userId {
                            self.commentKey = (key as? String)!
                            let type = commentDic["type"] as? String
                            if type == "Like" {
                                self.likeToggle = true
                                self.toggleLikeDislike()
                            }else if type == "Dislike" {
                                self.likeToggle = false
                                self.toggleLikeDislike()
                            }else{
                                NSLog("generanl user comments")
                            }
                            
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
        let postDateDate = dateFormatter.date(from: postDate)
        
        let dateFormatter2 = DateFormatter()
        dateFormatter2.dateFormat = "EEEE, MMM dd, yyyy. HH':'mm"
        let currentDateString: String = dateFormatter2.string(from: postDateDate!)
        return currentDateString
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if scrollView == self.scrollView{
           // scrollView.contentOffset.y = scrollView.contentOffset.y + tableView.frame.height
            print("scrollview")
        }
        else if scrollView == self.tableView{
             print("tableview")
        }
       
        
    }
}

extension NewsDetailedViewController:UITableViewDataSource,UITableViewDelegate{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return comments.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CommentsTableCell") as! CommentsTableCell
       
        let url = comments[indexPath.row].profileImageUrl as String
        cell.profileImageView.loadImageUsingCache(urlStr: url)
        cell.comment.text = comments[indexPath.row].comments as String
        return cell
    }
    
   func tableView(_ tableView: UITableView,heightForRowAt indexPath: IndexPath) -> CGFloat{
    
        let estimatedHgt = CommonUtils.calculateHeight(text: comments[indexPath.row].comments,width: tableView.layer.frame.width-50)
        let height = estimatedHgt < 40 ? 40 : estimatedHgt
        return height
    }
    
}
