//
//  RadioButton.swift
//  AmericasVision
//
//  Created by Mohan Dola on 02/08/18.
//  Copyright © 2018 zeroGravity. All rights reserved.
// 10

import Foundation

import UIKit

class AVRadioButton: UIButton {
    
    var alternateButton = [AVRadioButton]()
    
    override func awakeFromNib() {
        let image = UIImage(named: "like")
        self.setImage(image?.withRenderingMode(UIImageRenderingMode.alwaysTemplate), for: .normal)
        self.tintColor = UIColor.gray
        self.layer.masksToBounds = true
    }
    
    func unselectAlternateButtons(){
        if alternateButton != nil {
            self.isSelected = true
            
            for aButton:AVRadioButton in alternateButton {
                aButton.isSelected = false
            }
        }else{
            toggleButton()
        }
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        unselectAlternateButtons()
        super.touchesBegan(touches, with: event)
    }
    
    func toggleButton(){
        self.isSelected = !isSelected
    }
    
    override var isSelected: Bool {
        didSet {
            if isSelected {
                self.tintColor = UIColor.blue
            } else {
                //self.layer.backgroundColor = UIColor.gray.cgColor
                self.tintColor = UIColor.gray
            }
        }
    }
    
   
}
