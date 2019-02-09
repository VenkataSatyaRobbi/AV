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

class ChatPrivateViewController: JSQMessagesViewController,PrivateMessageReceivedDelegate, UIImagePickerControllerDelegate,UINavigationControllerDelegate {
    
    var contact:Contacts?
    
    private var messages = [JSQMessage]()
    
    let picker =  UIImagePickerController();

    @IBOutlet weak var backToContacts: UIBarButtonItem!
    
    @IBAction func goBack(_ sender: Any) {
        self.navigationController?.popToRootViewController(animated: true)
        dismiss(animated: true, completion: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        picker.delegate = self
        PrivateMessageHandler.Instance.delegate = self
        view.backgroundColor = UIColor.white
        self.senderId = AVAuthService.getCurrentUserId()
        self.senderDisplayName = AVAuthService.getCurrentUserName()
        self.navigationItem.title = contact?.name
         
        PrivateMessageHandler.Instance.observeMessages(contactId:(contact?.id)!)
        self.collectionView.collectionViewLayout.incomingAvatarViewSize = CGSize.zero;
        self.collectionView.collectionViewLayout.outgoingAvatarViewSize = CGSize.zero;
    }

    override func viewWillAppear(_ animated: Bool) {
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    override func didPressSend(_ button: UIButton!, withMessageText text: String!, senderId: String!, senderDisplayName: String!, date: Date!) {
        let receiverId = contact?.id
        let receiverName = contact?.name
        PrivateMessageHandler.Instance.sendMessage(senderId: senderId, senderName: senderDisplayName, text: text,url:"",receiverId:receiverId!,receiverName:receiverName!)
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
        let receiverId = contact?.id
        let receiverName = contact?.name
        if let pic = info[UIImagePickerControllerOriginalImage] as? UIImage{
            let data = UIImageJPEGRepresentation(pic,0.01)
            PrivateMessageHandler.Instance.sendMedia(image: data, video: nil, senderId: senderId, senderName: senderDisplayName,receiverId:receiverId!,receiverName:receiverName!)
        }else if let vid = info[UIImagePickerControllerMediaURL] as? URL{
            PrivateMessageHandler.Instance.sendMedia(image: nil, video: vid, senderId: senderId, senderName: senderDisplayName,receiverId:receiverId!,receiverName:receiverName!)
        }
        self.dismiss(animated: true, completion: nil)
        collectionView.reloadData()
    }
    
    func messageReceived(senderId: String, senderName:String,date:Date,text: String,url:String,receiverID:String) {
        
        if text.isEmpty {
            if let mediaUrl = URL(string: url){
                do{
                    let data = try Data(contentsOf: mediaUrl);
                    if let _ = UIImage(data:data){
                        let _ = SDWebImageDownloader.shared().downloadImage(with: mediaUrl, options: [], progress: nil, completed: { (image,data,error,finished) in
                            DispatchQueue.main.async {
                                let photo = JSQPhotoMediaItem(image:image)
                                if senderId == self.senderId{
                                    photo?.appliesMediaViewMaskAsOutgoing = true
                                }else{
                                    photo?.appliesMediaViewMaskAsOutgoing = false
                                }
                                self.messages.append(JSQMessage(senderId: senderId, senderDisplayName: senderName, date: date, media: photo))
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
        }else{
            messages.append(JSQMessage(senderId: senderId, senderDisplayName: senderName, date: date, text:text))
            collectionView.reloadData()
        }
     }
    
    //Collection view functions
    
    override func collectionView(_ collectionView: JSQMessagesCollectionView!, messageBubbleImageDataForItemAt indexPath: IndexPath!) -> JSQMessageBubbleImageDataSource! {
        let bubbleImageFactory = JSQMessagesBubbleImageFactory()
        let message = messages[indexPath.item]
        if message.senderId == self.senderId {
            return bubbleImageFactory?.outgoingMessagesBubbleImage(with: UIColor(red:0.08, green:0.45, blue:0.79, alpha:1.0))
        }else{
             return bubbleImageFactory?.incomingMessagesBubbleImage(with: UIColor(red:0.57, green:0.57, blue:0.58, alpha:1.0))
        }
    }
    
    override func collectionView(_ collectionView: JSQMessagesCollectionView!, avatarImageDataForItemAt indexPath: IndexPath!) -> JSQMessageAvatarImageDataSource! {
        return nil
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
       return messages.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = super.collectionView(collectionView, cellForItemAt: indexPath) as! JSQMessagesCollectionViewCell
        //cell.textView.textColor = UIColor(red:0.20, green:0.23, blue:0.23, alpha:1.0)
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
    
    override func collectionView(_ collectionView: JSQMessagesCollectionView!, attributedTextForCellBottomLabelAt indexPath: IndexPath!) -> NSAttributedString! {
        let message = messages[indexPath.item]
        let text = CommonUtils.convertStringFromDate(date: message.date)
        let textRange = NSRange(location: 0, length: (text.count))
        let paragraph = NSMutableParagraphStyle()
        if message.senderId == self.senderId {
            paragraph.alignment = .right
        }else{
            paragraph.alignment = .left
        }
        let attributedText = NSMutableAttributedString(string: text,attributes: [.paragraphStyle: paragraph])
        attributedText.addAttribute(NSAttributedStringKey.underlineStyle, value: NSUnderlineStyle.styleSingle.rawValue, range: textRange)
        return attributedText
    }
    
    override func collectionView(_ collectionView: JSQMessagesCollectionView!, layout collectionViewLayout: JSQMessagesCollectionViewFlowLayout!, heightForCellBottomLabelAt indexPath: IndexPath!) -> CGFloat {
        return 20
    }

}

