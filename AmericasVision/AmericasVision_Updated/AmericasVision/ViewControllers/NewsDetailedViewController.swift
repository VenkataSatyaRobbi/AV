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

class NewsDetailedViewController: UIViewController {

    var getPhotoCourtesy = String()
    var getContent = String()
    var getLocation = String()
    var getPhotoURL = String()
    var likes = NSNumber()
    var dislikes = NSNumber()
    var postId = String()
    var likeToggle: Bool = false
    
    @IBOutlet weak var dislikesCount: UILabel!
    @IBOutlet weak var likesCount: UILabel!
    @IBOutlet weak var NewsDetailedVCNewsContent: UILabel!
    @IBOutlet weak var NewsDetailedVCImage: UIImageView!
    @IBOutlet weak var NewsDetailedVCImageCourtesy: UILabel!
    @IBOutlet weak var NewsDetailedVCImageCaption: UILabel!
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var dislikeButton: UIButton!
    @IBOutlet weak var likeButton: UIButton!
    
    @IBAction func likesAction(_ sender: Any) {
        print("likes")
        let postRef = DBProvider.instance.newsFeedRef.child(postId)
        if(likeToggle){
            let dislikecount = self.dislikes.intValue - 1
            let value = dislikecount as NSNumber
            self.dislikes = value
            self.dislikesCount.text = value.stringValue
            NSLog("remove user dislike comments and add like comment section")
            postRef.child("userId").queryEqual(toValue: AVAuthService.getCurrentUserId()).observe(.childRemoved){
                (snapshot: DataSnapshot) in
                    snapshot.ref.removeValue()
            }
        }
        let commentsRef =  postRef.child("usercomments").child(postRef.childByAutoId().key)
        commentsRef.setValue(["type": "Like", "userId": AVAuthService.getCurrentUserId(),
                              "comments": ""], withCompletionBlock:{(error, ref) in
            if error != nil{
                ProgressHUD.showError(error!.localizedDescription)
                return
            }
            self.likeToggle = true
            let likecount = self.likes.intValue + 1
            let value = likecount as NSNumber
            self.likes = value
            self.likesCount.text = value.stringValue
            self.toggleLikeDislike()
        })
        
    }
    
    @IBAction func dislikeAction(_ sender: Any) {
        print("dislikes")
        let postRef = DBProvider.instance.newsFeedRef.child(postId)
        let userId = AVAuthService.getCurrentUserId()
        if(likeToggle){
            let likecount = self.likes.intValue - 1
            let value = likecount as NSNumber
            self.likes = value
            self.likesCount.text = value.stringValue
            NSLog("remove user like comments and add dislike comment section")
            postRef.child("userId").queryEqual(toValue: userId).observe(.childRemoved) { (snapshot: DataSnapshot) in
                snapshot.ref.removeValue()
            }
        }
        let commentsRef =  postRef.child("usercomments").child(postRef.childByAutoId().key)
        commentsRef.setValue(["type": "Dislike", "userId": userId ,
          "comments": ""], withCompletionBlock:{(error, ref) in
            if error != nil{
                ProgressHUD.showError(error!.localizedDescription)
                return
            }
            self.likeToggle = false
            let dislikecount = self.dislikes.intValue + 1
            let value = dislikecount as NSNumber
            self.dislikes = value
            self.dislikesCount.text = value.stringValue
            self.toggleLikeDislike()
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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        NewsDetailedVCNewsContent.numberOfLines = 0;
        NewsDetailedVCNewsContent.text! = getContent
        NewsDetailedVCNewsContent .sizeToFit()
        NewsDetailedVCImageCourtesy.text! = getPhotoCourtesy
        NewsDetailedVCImageCaption.numberOfLines = 0;
        NewsDetailedVCImageCaption.text! = getLocation
        NewsDetailedVCImageCaption .sizeToFit()
        likesCount.text = likes.stringValue
        dislikesCount.text = dislikes.stringValue
        scrollView.contentSize = CGSize(width: self.view.frame.size.width, height:self.view.frame.size.height+500)
        scrollView.isScrollEnabled = true
        self.navigationItem.title = "Details"
       
        let NewsDetailAVPostStorageRef = Storage.storage().reference(forURL: getPhotoURL)
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
        checkCurrentUserComments()
        // Do any additional setup after loading the view.
    }
    
    func checkCurrentUserComments(){
        DBProvider.instance.newsFeedRef.child(postId).child("usercomments").child("userId").queryEqual(toValue: AVAuthService.getCurrentUserId()).observeSingleEvent(of: DataEventType.value){
            (snapshot: DataSnapshot) in
            if let dict = snapshot.value as? [String: Any] {
                let type = dict["type"] as! String
                if type == "Like" {
                    self.likeToggle = true
                }else{
                    self.likeToggle = false
                }
            }
        }
        toggleLikeDislike()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}
