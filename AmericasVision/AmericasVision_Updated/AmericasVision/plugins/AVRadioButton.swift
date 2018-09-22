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
        self.heightAnchor.constraint(equalToConstant: 24).isActive = true
        self.widthAnchor.constraint(equalToConstant: 24).isActive = true
        self.layer.cornerRadius = 12
        self.layer.borderWidth = 1.0
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
                self.layer.backgroundColor = UIColor.blue.cgColor
                self.layer.borderColor = UIColor.blue.cgColor
                let image = UIImage(named: "check")
                self.setBackgroundImage(image, for: UIControlState.normal)
            } else {
                self.layer.backgroundColor = UIColor.white.cgColor
                  
            }
        }
    }
    
   
}
