//
//  NewsfeedViewController.swift
//  AmericasVision
//
//  Created by Venkata Satya R Robbi on 4/1/18.
//  Copyright © 2018 zeroGravity. All rights reserved.
//

import UIKit
import FirebaseAuth
import FirebaseDatabase
import FirebaseStorage

class NewsfeedViewController: UIViewController, UIPickerViewDataSource, UIPickerViewDelegate{
    
    @IBOutlet weak var ProfileButton: UIBarButtonItem!
    @IBOutlet weak var NewsCollectionView: UICollectionView!
    
    let PickerViewCategoryTab = UIPickerView()
    
    let postCategories = ["Category1","Category2","Category3","Categroya4"]
    
    var posts = [Post]()
    var postCategory = ""
    var rotationAngle: CGFloat!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        PickerViewCategoryTab.delegate = self
        PickerViewCategoryTab.dataSource = self
        
        PickerViewCategoryTab.layer.borderWidth = 0.5
        PickerViewCategoryTab.layer.borderColor = UIColor.blue.cgColor
        PickerViewCategoryTab.backgroundColor = UIColor(displayP3Red: 48/255, green: 106/255, blue: 148/255, alpha: 1)

        rotationAngle = -90 * (.pi/180)
        PickerViewCategoryTab.transform = CGAffineTransform(rotationAngle: rotationAngle)
        
        PickerViewCategoryTab.frame = CGRect(x: 0 - 150, y: 65, width: view.frame.width + 300, height: 30)
        self.view.addSubview(PickerViewCategoryTab)
        
        NewsCollectionView.isHidden = true
        NewsCollectionView.dataSource = self
        
        view.backgroundColor = UIColor.white
        
        sideMenus()
        postCategory = "Category1"
        loadPosts()
        
        //var post = Post(captionText: "enw", photoUrlString: "newurl")
        // Do any additional setup after loading the view.
    }
    

    func loadPosts(){
        Database.database().reference().child("posts").queryOrdered(byChild: "category").queryEqual(toValue: postCategory).observe(.childAdded) { (snapshot: DataSnapshot) in
            //print(snapshot.value)
            if let dict = snapshot.value as? [String: Any] {
                let captionText = dict["caption"] as! String
                let photoUrlString = dict["photoUrl"] as! String
                let postCategoryString = dict["category"] as! String
                let postTitleString = dict["title"] as! String
                let postLikesInt = dict["likes"] as! Int
                let postDislikesInt = dict["dislikes"] as! Int
                let postCommentsInt = dict["comments"] as! Int
                let post = Post(captionText: captionText, photoUrlString: photoUrlString, postCategoryString: postCategoryString, postTitleString: postTitleString, postLikesInt: postLikesInt, postDislikesInt: postDislikesInt, postCommentsInt: postCommentsInt)
                self.posts.append(post)
                print("loading posts..")
                print(self.posts)
                self.NewsCollectionView.reloadData()
            }
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func sideMenus(){
        if revealViewController() != nil {
            ProfileButton.target = revealViewController()
            ProfileButton.action = #selector(SWRevealViewController.revealToggle(_:))
            revealViewController().rearViewRevealWidth = 260
            view.addGestureRecognizer(self.revealViewController().panGestureRecognizer())
        }
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return postCategories.count
    }
    
    func pickerView(_ pickerView: UIPickerView, rowHeightForComponent component: Int) -> CGFloat {
        return 150
    }
    
    func pickerView(_ pickerView: UIPickerView, widthForComponent component: Int) -> CGFloat {
        return 30
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        posts.removeAll()
        postCategory = postCategories[row]
        loadPosts()
    }
    
    func pickerView(_ pickerView: UIPickerView, viewForRow row: Int, forComponent component: Int, reusing view: UIView?) -> UIView {
        let view = UIView()
        view.frame = CGRect(x: 0, y: 0, width: 100, height: 30)
        
        let label = UILabel()
        label.frame = CGRect(x: 0, y: 0, width: 100, height: 30)
        label.textAlignment = .center
        label.font = UIFont.systemFont(ofSize: 16, weight: UIFont.Weight.semibold)
        label.text = postCategories[row]
        label.textColor = .white
        view.addSubview(label)
        
        view.transform = CGAffineTransform(rotationAngle: 90 * (.pi/180))
        
        return view
    }
}

extension NewsfeedViewController: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return posts.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {

        let item = NewsCollectionView.dequeueReusableCell(withReuseIdentifier: "PostCollectionViewCell", for: indexPath) as! PostCollectionViewCell
        
        item.PostCollectionViewText.text  = posts[indexPath.item].caption
        item.PostCollectionViewTitle.text = posts[indexPath.item].postTitle
        item.PostCollectionViewLikes.text = "\(posts[indexPath.item].postLikes)"
        item.PostCollectionViewDislikes.text = "\(posts[indexPath.item].postDislikes)"
        item.PostCollectionViewComments.text = "\(posts[indexPath.item].postComments)"
        
        let AVPostStorageRef = Storage.storage().reference(forURL: posts[indexPath.item].photoUrl)
        AVPostStorageRef.downloadURL { (url, error) in
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
                    item.PostCollectionViewImage.image = imageData
                }
                
            }).resume()
            
        }
        return item
    }
}
