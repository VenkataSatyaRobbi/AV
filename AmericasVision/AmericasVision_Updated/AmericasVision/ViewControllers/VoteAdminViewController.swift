//
//  VoteAdminViewController.swift
//  AmericasVision
//
//  Created by Mohan Dola on 01/08/18.
//  Copyright © 2018 zeroGravity. All rights reserved.
//

import Foundation

class VoteAdminViewController: UIViewController{
    
    @IBOutlet weak var QuestionsView: UITextView!
    @IBOutlet weak var optionOne: UITextField!
    @IBOutlet weak var oPtionTwo: UITextField!
    @IBOutlet weak var opTionThree: UITextField!
    @IBOutlet weak var SendButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        QuestionsView.layer.cornerRadius = 5
        QuestionsView.clipsToBounds = true
        SendButton.layer.cornerRadius = 5
        SendButton.clipsToBounds = true
        
        QuestionsView.text = "Questions"
        QuestionsView.textColor = UIColor.lightGray
        
        optionOne.text = nil
        optionOne.placeholder = "Option One"
        
        oPtionTwo.text = nil
        oPtionTwo.placeholder = "Option Two"
        
        opTionThree.text = nil
        opTionThree.placeholder = "Option Three"
      
    }
    
    @IBAction func publishAction(_ sender: Any) {
        let postedDate = NSDate().timeIntervalSince1970
        DBProvider.instance.opinionRef.childByAutoId().setValue(["Question": QuestionsView.text, "Option1": optionOne.text,"Option2": oPtionTwo.text,"Option3": opTionThree.text, "Date": postedDate],withCompletionBlock:{(error, ref) in
            if error != nil{
                ProgressHUD.showError(error!.localizedDescription)
                return
            }
            ProgressHUD.showSuccess("Done")
            self.dismiss(animated: true, completion: nil)
        })
    }
    
}
