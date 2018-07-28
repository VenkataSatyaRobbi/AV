//
//  ChatPublicViewController.swift
//  AmericasVision
//
//  Created by Mohan Dola on 06/06/18.
//  Copyright © 2018 zeroGravity. All rights reserved.
//

import UIKit
import JSQMessagesViewController
import MobileCoreServices
import FirebaseDatabase
import FirebaseStorage
import AVKit
import SDWebImage


class ChatPublicViewController: JSQMessagesViewController,PublicMessageReceivedDelegate, UIImagePickerControllerDelegate,UINavigationControllerDelegate {

    private var messages = [JSQMessage]()
    
    let picker =  UIImagePickerController();
    
    @IBOutlet weak var backToContacts: UIBarButtonItem!
    
    @IBAction func goBack(_ sender: Any) {
        //dismiss(animated: true, completion: nil)
         self.dismiss(animated: true)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        picker.delegate = self
        PublicMessageHandler.Instance.delegate = self
        view.backgroundColor = UIColor.groupTableViewBackground
        self.senderId = AVAuthService.getCurrentUserId()
        self.senderDisplayName = AVAuthService.getCurrentUserName()
        self.navigationItem.title = "AV Public Chat"
        
        PublicMessageHandler.Instance.observeMessages()
        PublicMessageHandler.Instance.observeMediaMessages()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    override func didPressSend(_ button: UIButton!, withMessageText text: String!, senderId: String!, senderDisplayName: String!, date: Date!) {
        PublicMessageHandler.Instance.sendMessage(senderId: senderId, senderName: senderDisplayName, text: text)
        finishSendingMessage()
    }
    
    override func didPressAccessoryButton(_ sender: UIButton!) {
        let alert = UIAlertController(title: "Media Messages", message: "please select a media", preferredStyle: .actionSheet)
        let cancel = UIAlertAction(title: "Cancel", style: .default, handler: nil)
        let photos = UIAlertAction(title: "Photos", style: .default, handler:{ (alert: UIAlertAction) in
            self.chooseMedia(type: kUTTypeImage)
        })
        
        let videos = UIAlertAction(title: "Videos", style: .default, handler:{ (alert: UIAlertAction) in
            self.chooseMedia(type: kUTTypeMovie)
        })
        
        alert.addAction(cancel)
        alert.addAction(photos)
        alert.addAction(videos)
        present(alert,animated: true,completion: nil)
        
    }
    
    private func chooseMedia(type:CFString){
        picker.mediaTypes = [type as String]
        present(picker,animated: true,completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        if let pic = info[UIImagePickerControllerOriginalImage] as? UIImage{
            let data = UIImageJPEGRepresentation(pic,0.01)
            PublicMessageHandler.Instance.sendMedia(image: data, video: nil, senderId: senderId, senderName: senderDisplayName)
        }else if let vid = info[UIImagePickerControllerMediaURL] as? URL{
            PublicMessageHandler.Instance.sendMedia(image: nil, video: vid, senderId: senderId, senderName: senderDisplayName)
        }
        self.dismiss(animated: true, completion: nil)
        collectionView.reloadData()
    }
    
    func messageReceived(senderId: String, senderName:String,text: String) {
        messages.append(JSQMessage(senderId: senderId, displayName: senderName, text: text))
        collectionView.reloadData()
    }
    
    func messageReceived(senderId: String, senderName:String,url: String) {
        if let mediaUrl = URL(string: url){
            do{
                let data = try Data(contentsOf: mediaUrl);
                if let _ = UIImage(data:data){
                    let _ = SDWebImageDownloader.shared().downloadImage(with: mediaUrl, options: [], progress: nil, completed: { (image,data,error,finished) in
                        
                        DispatchQueue.main.sync(){
                            let photo = JSQPhotoMediaItem(image:image)
                            if senderId == self.senderId{
                                photo?.appliesMediaViewMaskAsOutgoing = true
                            }else{
                                photo?.appliesMediaViewMaskAsOutgoing = false
                            }
                            self.messages.append(JSQMessage(senderId: senderId, displayName: senderName, media: photo))
                           // self.collectionView.reloadData()
                        }
                    })
                }else{
                    print("test")
                }
            }catch{
                print("exceptions")
            }
        }
    }
    
    //Collection view functions

    override func collectionView(_ collectionView: JSQMessagesCollectionView!, messageBubbleImageDataForItemAt indexPath: IndexPath!) -> JSQMessageBubbleImageDataSource! {
        let bubbleImageFactory = JSQMessagesBubbleImageFactory()
        let message = messages[indexPath.item]
        if message.senderId == self.senderId {
            return bubbleImageFactory?.outgoingMessagesBubbleImage(with: UIColor(red:0.79, green:0.91, blue:0.96, alpha:1.0))
        }else{
            return bubbleImageFactory?.incomingMessagesBubbleImage(with: UIColor(red:0.89, green:0.91, blue:0.91, alpha:1.0))
        }
        
    }
    
    override func collectionView(_ collectionView: JSQMessagesCollectionView!, avatarImageDataForItemAt indexPath: IndexPath!) -> JSQMessageAvatarImageDataSource! {
       
        let  placeHolderImage = UIImage(named: "profile")
        
        let avatarImage = JSQMessagesAvatarImageFactory.avatarImage(with: placeHolderImage, diameter: 30)
        
        let message = messages[indexPath.item]
        avatarImage?.avatarImage = SDImageCache.shared().imageFromDiskCache(forKey: message.senderId)
        
        if let messageId = message.senderId {
            DBProvider.instance.userRef.child(messageId).observe(.value, with: { (snapshot: DataSnapshot) in
                if let profileImageUrl = (snapshot.value as AnyObject!)!["ProfileImageURL"] as! String! {
                    let mediaUrl = URL(string: profileImageUrl)!
                    let _ = SDWebImageDownloader.shared().downloadImage(with: mediaUrl , options: [], progress: nil, completed: {(image,data,error,finished) in
                            SDWebImageManager.shared().imageCache?.store(image, forKey: message.senderId)
                            DispatchQueue.main.async {
                                avatarImage!.avatarImage = image
                                
                            }
                        })
                    }
                })
            }
        
        return avatarImage
    }
   
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return messages.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = super.collectionView(collectionView, cellForItemAt: indexPath) as! JSQMessagesCollectionViewCell
        cell.avatarImageView.layer.cornerRadius = (cell.avatarImageView.frame.size.width-4)/2
        NSLog("imsize", cell.avatarImageView.frame.size.width)
        cell.avatarImageView.clipsToBounds = true
        cell.textView.textColor = UIColor(red:0.20, green:0.23, blue:0.23, alpha:1.0)
        return cell
    }
    
    override func collectionView(_ collectionView: JSQMessagesCollectionView!, messageDataForItemAt indexPath: IndexPath!) -> JSQMessageData! {
        return messages[indexPath.item]
    }
    
    override func collectionView(_ collectionView: JSQMessagesCollectionView!, didTapMessageBubbleAt indexPath: IndexPath!) {
        let messageItem = messages[indexPath.item]
        if let mediaItem = messageItem.media as? JSQVideoMediaItem {
            let player = AVPlayer(url: mediaItem.fileURL)
            let playerController = AVPlayerViewController()
            playerController.player = player
            self.present(playerController, animated: true, completion: nil)
        }
    }

}
