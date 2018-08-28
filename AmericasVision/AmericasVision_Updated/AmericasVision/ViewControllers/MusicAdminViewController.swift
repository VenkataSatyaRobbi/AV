//
//  MusicAdminViewController.swift
//  AmericasVision
//
//  Created by Mohan Dola on 04/06/18.
//  Copyright © 2018 zeroGravity. All rights reserved.
//

import UIKit
import FirebaseStorage
import FirebaseDatabase
import FirebaseAuth

import MobileCoreServices
class MusicAdminViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    var url:NSURL! = nil
    var startTime: CGFloat = 0.0
    var stopTime: CGFloat  = 0.0
   
    var thumbtimeSeconds: Int!
  
    
    var imagePickerController = UIImagePickerController()
    var videoURL: URL?
    
    private func openImgPicker() {
        imagePickerController.sourceType = .savedPhotosAlbum
        imagePickerController.delegate = self
        imagePickerController.mediaTypes = ["public.movie"]
        present(imagePickerController, animated: true, completion: nil)
    }
    
   
    
    
    
    let imageView : UIImageView = {
        let view = UIImageView()
       // view.backgroundColor = UIColor.red
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let chooseBtn: UIButton = {
        let btn = UIButton()
        btn.backgroundColor = UIColor.blue
        btn.setTitle("Choose Video's", for: .normal)
        btn.layer.cornerRadius = 5
        btn.translatesAutoresizingMaskIntoConstraints = false
        return btn
    }()
    
   // var imagePickerController: UIImagePickerController!
    
    override func viewDidLoad() {
        super.viewDidLoad()
       
       
        imagePickerController = UIImagePickerController()
        imagePickerController.delegate = self
       
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    override func viewWillAppear(_ animated: Bool) {
       // self.view.addSubview(imageView)
        self.view.addSubview(chooseBtn)
       
        
      
//        imageView.widthAnchor.constraint(equalToConstant: self.view.frame.width).isActive = true
//        imageView.heightAnchor.constraint(equalToConstant: self.view.frame.height/2).isActive = true
//        imageView.topAnchor.constraint(equalTo: self.view.topAnchor, constant: 5).isActive = true
//
       
        
        chooseBtn.topAnchor.constraint(equalTo: self.view.topAnchor, constant:70).isActive = true
        chooseBtn.leftAnchor.constraint(equalTo: self.view.leftAnchor, constant:self.view.frame.width/2 - 85).isActive = true
        chooseBtn.heightAnchor.constraint(equalToConstant:40).isActive = true
        chooseBtn.widthAnchor.constraint(equalToConstant:self.view.frame.width/2).isActive = true
        
         chooseBtn.addTarget(self,action: #selector(selectVideoUrl(_:)),for: .touchUpInside)
}
    
//    @IBAction func upload(sender: AnyObject) {
//        if let image = self.imageView.image {
//
//            ProgressHUD.show("Uploading..", interaction: false)
//            if let postPlaceHolderPhoto = self.imageView.image, let imageData = UIImageJPEGRepresentation(postPlaceHolderPhoto, 0.1) {
//                let photoIdString = NSUUID().uuidString
//                print(photoIdString)
//                let AVStorageRef = Storage.storage().reference(forURL: PropertyConfig.FIRSTORAGE_ROOT_REF).child("musicalbum").child(photoIdString)
//                AVStorageRef.putData(imageData, metadata: nil, completion: { (metadata, error) in
//                    if error != nil{
//                        ProgressHUD.showError(error!.localizedDescription)
//                        return
//                    }
//                    let postPhotoUrl = metadata?.downloadURL()?.absoluteString
//                    self.saveDatatoDatabase(photoUrl: postPhotoUrl!)
//                })
//            }else {
//                ProgressHUD.showError("Photo cannot be blank")
//                //print("Profile photo cannot be blank")
//            }
//
//
//            let alertWarning = UIAlertView(title:"Warning", message: "You don't have access on Firebase", delegate:nil, cancelButtonTitle:"OK", otherButtonTitles:"Cancel")
//            alertWarning.show()
//
//        }
//    }
    func saveDatatoDatabase(photoUrl: String){
        let AVDBref = Database.database().reference()
        let AVDBpostsref = AVDBref.child("musicalbum")
        let newPostId = AVDBpostsref.childByAutoId().key
        let AVDBnewpostref = AVDBpostsref.child(newPostId)
        AVDBnewpostref.setValue((Auth.auth().currentUser?.uid)!, andPriority: ServerValue.timestamp(), withCompletionBlock: {
            (error, ref) in
            if error != nil{
                ProgressHUD.showError(error!.localizedDescription)
                return
            }
            ProgressHUD.showSuccess("Done")
            
            self.imageView.image = UIImage(named: "audio")
            
            self.dismiss(animated: true, completion: nil)
        })
    }
    
    //MARK: - UIImagePickerControllerDelegate Methods -
    
    func openCamera(){
        // alert.dismiss(animated: true, completion: nil)
        if(UIImagePickerController .isSourceTypeAvailable(.camera)){
            imagePickerController.sourceType = .camera
            self.present(imagePickerController, animated: true, completion: nil)
        } else {
            let alertWarning = UIAlertView(title:"Warning", message: "You don't have camera", delegate:nil, cancelButtonTitle:"OK", otherButtonTitles:"")
            alertWarning.show()
        }
    }
    func openGallery(){
        // alert.dismiss(animated: true, completion: nil)
        imagePickerController.sourceType = .photoLibrary
        self.present(imagePickerController, animated: true, completion: nil)
    }
    
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        picker.dismiss(animated: true, completion: nil)
        let image = info[UIImagePickerControllerOriginalImage] as! UIImage
        // pickImageCallback?(image)
        self.imageView.image = image
        dismiss(animated: true, completion: nil)
    }
    
    @objc func imagePickerController(_ picker: UIImagePickerController, pickedImage: UIImage?) {
    }
    
   @IBAction func chooseImage(sender: AnyObject) {
       //self.present(imagePickerController, animated: true, completion: nil)

       let alert:UIAlertController=UIAlertController(title: "Choose Image", message: nil, preferredStyle: UIAlertControllerStyle.actionSheet)
       //        let cameraAction = UIAlertAction(title: "Camera", style: UIAlertActionStyle.default)
       //        {
       //            UIAlertAction in
       //            self.openCamera()
       //        }
       let gallaryAction = UIAlertAction(title: "Gallary", style: UIAlertActionStyle.default)
       {
           UIAlertAction in
           self.openGallery()
       }
       let cancelAction = UIAlertAction(title: "Cancel", style: UIAlertActionStyle.cancel)
       {
           UIAlertAction in
       }

       // Add the actions
       imagePickerController.delegate = self
       // alert.addAction(cameraAction)
       alert.addAction(gallaryAction)
       alert.addAction(cancelAction)
       self.present(alert, animated: true, completion: nil)

   }
    
    
    //Action for select Video
    @IBAction func selectVideoUrl(_ sender: Any)
    {
        //Selecting Video type
        let myImagePickerController        = UIImagePickerController()
        myImagePickerController.sourceType = .photoLibrary
        myImagePickerController.mediaTypes = [(kUTTypeMovie) as String]
        myImagePickerController.delegate   = self
        myImagePickerController.isEditing  = false
        self.present(myImagePickerController, animated: true, completion:nil)
    }
    

    
}
