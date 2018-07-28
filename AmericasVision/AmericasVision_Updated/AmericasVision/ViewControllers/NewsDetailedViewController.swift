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
    var getCaption = String()
    var getPhotoURL = String()
    
    @IBOutlet weak var NewsDetailedVCNewsContent: UILabel!
    @IBOutlet weak var NewsDetailedVCImage: UIImageView!
    @IBOutlet weak var NewsDetailedVCImageCourtesy: UILabel!
    @IBOutlet weak var NewsDetailedVCImageCaption: UILabel!
    @IBOutlet weak var scrollView: UIScrollView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
     
        NewsDetailedVCNewsContent.numberOfLines = 0;
        NewsDetailedVCNewsContent.text! = getContent
        NewsDetailedVCNewsContent .sizeToFit()
        NewsDetailedVCImageCourtesy.text! = getPhotoCourtesy
        NewsDetailedVCImageCaption.numberOfLines = 0;
        NewsDetailedVCImageCaption.text! = getCaption
        NewsDetailedVCImageCaption .sizeToFit()
        
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
        // Do any additional setup after loading the view.
    }
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
   
//    @IBAction func Back_ToNewsFeed(_ sender: UIBarButtonItem) {
//        dismiss(animated: true, completion: nil)
//    }
//    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
//         dismiss(animated: true, completion: nil)
//    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
