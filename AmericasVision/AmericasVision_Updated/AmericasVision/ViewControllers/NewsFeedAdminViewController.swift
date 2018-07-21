////
//  NewsFeedAdminViewController.swift
//  AmericasVision
//
//  Created by Venkata Satya R Robbi on 4/14/18.
//  Copyright © 2018 zeroGravity. All rights reserved.
//

import UIKit
import FirebaseStorage
import FirebaseDatabase
import FirebaseAuth

class NewsFeedAdminViewController: UIViewController, UIPickerViewDataSource, UIPickerViewDelegate {
    
    @IBOutlet weak var PhotoCaptionAdmin: UITextView!
    @IBOutlet weak var PostAdminButton: UIButton!
    //@IBOutlet weak var PostCategoryAdminPickerView: UIPickerView!
    @IBOutlet weak var PostCategoryText: UITextField!
    @IBOutlet weak var CancelAdminButton: UIBarButtonItem!
    @IBOutlet weak var PostTitle: UITextField!
    @IBOutlet weak var PhotoAdmin: UIImageView!
    @IBOutlet weak var NewsLocationAdmin: UITextField!
    @IBOutlet weak var NewsContentAdmin: UITextView!
    @IBOutlet weak var PhotoCourtesyAdmin: UITextView!
    var PostSelectedPhoto: UIImage?
    var selectedPostCategory: String?
    //let postID = UUID().uuidString
    
    let PostCategory = ["Select Category","Category1","Category2","Category3","Category4"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let PostTapGesture = UITapGestureRecognizer(target: self, action: #selector(self.selectPostImage))
        PhotoAdmin.addGestureRecognizer(PostTapGesture)
        PhotoAdmin.isUserInteractionEnabled = true
        // Do any additional setup after loading the view.
        
        
        print(convertTimestamp(serverTimestamp: 1526426690527))
        
        alignments()

    }
    
    @IBAction func PostCategoryTextTouched(_ sender: Any) {
        let PostCategoryPickerView: UIPickerView = UIPickerView()
        PostCategoryPickerView.delegate = self
        PostCategoryText.inputView = PostCategoryPickerView
     
    }


    
     func alignments(){
        PhotoCaptionAdmin.layer.cornerRadius = 8
        PhotoCaptionAdmin.clipsToBounds = true
        PhotoCaptionAdmin.layer.borderWidth = 0.5
        
        PostAdminButton.layer.cornerRadius = 8
        PostAdminButton.clipsToBounds = true
        
        PhotoCourtesyAdmin.layer.cornerRadius = 8
        PhotoCourtesyAdmin.clipsToBounds = true
        PhotoCourtesyAdmin.layer.borderWidth = 0.5
        
        NewsContentAdmin.layer.cornerRadius = 8
        NewsContentAdmin.clipsToBounds = true
        NewsContentAdmin.layer.borderWidth = 0.5
        
        NewsLocationAdmin.layer.cornerRadius = 8
        NewsLocationAdmin.clipsToBounds = true
        NewsLocationAdmin.layer.borderWidth = 0.5
        
        PostTitle.layer.cornerRadius = 8
        PostTitle.clipsToBounds = true
        PostTitle.layer.borderWidth = 0.5

        PostCategoryText.layer.cornerRadius = 8
        PostCategoryText.clipsToBounds = true
        PostCategoryText.layer.borderWidth = 0.8
        
        
    }
        
    func convertTimestamp(serverTimestamp: Double) -> String {
        let timestampInSec = serverTimestamp / 1000
        let date = NSDate(timeIntervalSince1970: timestampInSec)
        let formatter = DateFormatter()
        formatter.dateStyle = .long
        formatter.timeStyle = .medium
        
        return formatter.string(from: date as Date)
    }
    
    @IBAction func CancelPostTouchUpInside(_ sender: UIBarButtonItem) {
        self.PhotoCaptionAdmin.text = ""
        self.PhotoAdmin.image = UIImage(named: "video")
        self.PostSelectedPhoto = nil
        self.selectedPostCategory = nil
        self.PostTitle.text = ""
        handlePost()
    }
    
    @objc func selectPostImage(){
        let postPhotoPickerController = UIImagePickerController()
        postPhotoPickerController.delegate = self
        present(postPhotoPickerController, animated: true, completion: nil)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        handlePost()
    }
    
    func handlePost(){
        if (PostSelectedPhoto != nil) {
            self.PostAdminButton.isEnabled = true
            self.PostAdminButton.backgroundColor = UIColor.blue
            self.CancelAdminButton.isEnabled = true
        }else{
            self.PostAdminButton.isEnabled = false
            self.PostAdminButton.backgroundColor = UIColor.gray
            self.CancelAdminButton.isEnabled = false
            //self.PostAdminButton.isHidden = true
        }
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        view.endEditing(true)
    }
    
    @IBAction func PostAdminButtonTouchUpInside(_ sender: Any) {
        
        if selectedPostCategory == "Select Category" || selectedPostCategory == nil{
            // create the alert
            let alert = UIAlertController(title: "Category missing", message: "Would you like to continue posting this?", preferredStyle: UIAlertControllerStyle.alert)
            
            // add the actions (buttons)
            alert.addAction(UIAlertAction(title: "Continue", style: UIAlertActionStyle.default, handler: {action in
                
                self.selectedPostCategory = "default"
                self.PostAdminButtonTouchUpInside((Any).self)
            }))
            alert.addAction(UIAlertAction(title: "Cancel", style: UIAlertActionStyle.cancel, handler: nil))
            
            // show the alert
            self.present(alert, animated: true, completion: nil)
            
        }else{
            ProgressHUD.show("Uploading..", interaction: false)
            if let postPlaceHolderPhoto = self.PostSelectedPhoto, let imageData = UIImageJPEGRepresentation(postPlaceHolderPhoto, 0.1) {
                let photoIdString = NSUUID().uuidString
                print(photoIdString)
                let AVStorageRef = Storage.storage().reference(forURL: PropertyConfig.FIRSTORAGE_ROOT_REF).child("posts").child(photoIdString)
                AVStorageRef.putData(imageData, metadata: nil, completion: { (metadata, error) in
                    if error != nil{
                        ProgressHUD.showError(error!.localizedDescription)
                        return
                    }
                    let postPhotoUrl = metadata?.downloadURL()?.absoluteString
                    self.saveDatatoDatabase(photoUrl: postPhotoUrl!)
                })
            }else {
                ProgressHUD.showError("Photo cannot be blank")
                //print("Profile photo cannot be blank")
            }
        }
    }
    
    @IBAction func BackButtonAdminTouchUpInside(_ sender: Any) {
      // self.dismiss(animated: true, completion: nil)
      
        //self.dismiss(animated: true, completion: nil)
            if let nav = self.navigationController {
                nav.dismiss(animated: true)
            } else {
                self.dismiss(animated: true, completion: nil)
            }
       
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func saveDatatoDatabase(photoUrl: String){
        let AVDBref = Database.database().reference()
        let AVDBpostsref = AVDBref.child("posts")
        let newPostId = AVDBpostsref.childByAutoId().key
        let AVDBnewpostref = AVDBpostsref.child(newPostId)
        AVDBnewpostref.setValue(["photoUrl": photoUrl, "title": PostTitle.text!, "caption": PhotoCaptionAdmin.text!, "category": selectedPostCategory ?? "Category4", "userid": (Auth.auth().currentUser?.uid)!, "postID": newPostId, "likes": 0, "dislikes": 0, "comments": 0, "timestamp": ServerValue.timestamp(), "photoCourtesy": PhotoCourtesyAdmin.text, "newsLocation": NewsLocationAdmin.text!, "newsContent": NewsContentAdmin.text!], withCompletionBlock: {
            (error, ref) in
            if error != nil{
                ProgressHUD.showError(error!.localizedDescription)
                return
            }
            ProgressHUD.showSuccess("Done")
            self.PhotoCaptionAdmin.text = ""
            self.PhotoAdmin.image = UIImage(named: "video")
            self.selectedPostCategory = nil
            self.dismiss(animated: true, completion: nil)
        })
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return PostCategory[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return PostCategory.count
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        selectedPostCategory = PostCategory[row]
        PostCategoryText.text = PostCategory[row]
    }
   
    
//    func pickerView(pickerView: UIPickerView, viewForRow row: Int, forComponent component: Int, reusingView view: UIView?) -> UIView {
//        let categoryData = PostCategory[row]
//        let myCategory = NSAttributedString(string: categoryData, attributes: [NSFontAttributeName:UIFont(name: "Avenir Next", size: 12.0)!,NSForegroundColorAttributeName:UIColor.blackColor()])
//       let myCategory = NSAttributedString(string: categoryData, attributes: [NSAttributedStringKey.foregroundColor: UIColor.blue, NSAttributedStringKey.font: UIFont.systemFont(ofSize: 12)] as [NSAttributedStringKey : Any]?)
//return myCategory
//    }
    
}
extension NewsFeedAdminViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        if let postPhoto = info["UIImagePickerControllerOriginalImage"] as? UIImage {
            PostSelectedPhoto = postPhoto
            PhotoAdmin.image = postPhoto
        }
        dismiss(animated: true, completion: nil)
    }
}
