//
//  ChatPrivateViewController.swift
//  AmericasVision
//
//  Created by Venkata Satya R Robbi on 5/5/18.
//  Copyright © 2018 zeroGravity. All rights reserved.
//

import UIKit
import JSQMessagesViewController
import MobileCoreServices
import AVKit
import SDWebImage

class ChatPrivateViewController: JSQMessagesViewController,MessageReceivedDelegate, UIImagePickerControllerDelegate,UINavigationControllerDelegate {
    
    var contact:Contacts?
    
    private var messages = [JSQMessage]()
    
    let picker =  UIImagePickerController();

    @IBOutlet weak var backToContacts: UIBarButtonItem!
    
    @IBAction func goBack(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        picker.delegate = self
        MessageHandler.Instance.delegate = self
        view.backgroundColor = UIColor.white
        self.senderId = contact?.id
        self.senderDisplayName = contact?.name
        self.navigationItem.title = contact?.name
         
       // let navImage = UIImage(named: "profile")
       // let profileImage = UIImageView(image: navImage)
       // profileImage.loadImageUsingCache(urlStr: (contact?.profileImageUrl)!)
       // self.navigationItem.leftBarButtonItems?.append(UIBarButtonItem(image: profileImage.image, style: UIBarButtonItemStyle.plain, target: nil, action: nil))
        MessageHandler.Instance.observeMessages()
        MessageHandler.Instance.observeMediaMessages()
    }

    override func viewWillAppear(_ animated: Bool) {
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    override func didPressSend(_ button: UIButton!, withMessageText text: String!, senderId: String!, senderDisplayName: String!, date: Date!) {
        MessageHandler.Instance.sendMessage(senderId: senderId, senderName: senderDisplayName, text: text)
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
            MessageHandler.Instance.sendMedia(image: data, video: nil, senderId: senderId, senderName: senderDisplayName)
           //let image = JSQPhotoMediaItem(image:pic)
           //self.messages.append(JSQMessage(senderId: senderId, displayName: senderDisplayName, media: image))
        }else if let vid = info[UIImagePickerControllerMediaURL] as? URL{
            //let video = JSQVideoMediaItem(fileURL: vid, isReadyToPlay: true)
            //self.messages.append(JSQMessage(senderId: senderId, displayName: senderDisplayName, media: video    ))
            MessageHandler.Instance.sendMedia(image: nil, video: vid, senderId: senderId, senderName: senderDisplayName)
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
                            self.collectionView.reloadData()
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
            return bubbleImageFactory?.outgoingMessagesBubbleImage(with: UIColor.blue)
        }else{
             return bubbleImageFactory?.incomingMessagesBubbleImage(with: UIColor.blue)
        }
        
    }
    
    override func collectionView(_ collectionView: JSQMessagesCollectionView!, avatarImageDataForItemAt indexPath: IndexPath!) -> JSQMessageAvatarImageDataSource! {
        return JSQMessagesAvatarImageFactory.avatarImage(with: UIImage(named: "profilephotoplaceholder"), diameter: 30)
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
       return messages.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = super.collectionView(collectionView, cellForItemAt: indexPath) as! JSQMessagesCollectionViewCell
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

