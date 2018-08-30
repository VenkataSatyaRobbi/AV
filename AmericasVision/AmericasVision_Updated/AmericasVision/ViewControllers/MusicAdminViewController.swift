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
    
    let imagePicker = UIImagePickerController()
    
    
    let imageView : UIImageView = {
        let view = UIImageView()
        
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
    
    
    
    
    @IBAction func loadImageButtonTapped(sender: UIButton) {
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        imagePicker.delegate = self
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    override func viewWillAppear(_ animated: Bool) {
        // self.view.addSubview(imageView)
        self.view.addSubview(chooseBtn)
        
        
       // imageView.topAnchor.constraint(equalTo: self.view.topAnchor, constant:120).isActive = true
        imageView.widthAnchor.constraint(equalToConstant: self.view.frame.width).isActive = true
        imageView.heightAnchor.constraint(equalToConstant: self.view.frame.height/2).isActive = true
      
        
        
        chooseBtn.topAnchor.constraint(equalTo: self.view.topAnchor, constant:70).isActive = true
        chooseBtn.leftAnchor.constraint(equalTo: self.view.leftAnchor, constant:self.view.frame.width/2 - 85).isActive = true
        chooseBtn.heightAnchor.constraint(equalToConstant:40).isActive = true
        chooseBtn.widthAnchor.constraint(equalToConstant:self.view.frame.width/2).isActive = true
        
        chooseBtn.addTarget(self,action: #selector(selectVideoUrl(_:)),for: .touchUpInside)
    }
    
    
    // MARK: - UIImagePickerControllerDelegate Methods
    
    func imagePickerController(picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : AnyObject]) {
        if let pickedImage = info[UIImagePickerControllerOriginalImage] as? UIImage {
            imageView.contentMode = .scaleAspectFit
            imageView.image = pickedImage
        }
        
        dismiss(animated: true, completion: nil)
    }
    
    func imagePickerControllerDidCancel(picker: UIImagePickerController) {
        dismiss(animated: true, completion: nil)
    }
    //Action for select Video
    @IBAction func selectVideoUrl(_ sender: Any)
    {
        //Selecting Video type
        imagePicker.allowsEditing = false
        imagePicker.sourceType = .photoLibrary
        
        present(imagePicker, animated: true, completion: nil)
    }
    
    
    
}
