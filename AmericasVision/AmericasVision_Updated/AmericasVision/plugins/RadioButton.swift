//
//  RadioButton.swift
//  AmericasVision
//
//  Created by Mohan Dola on 02/08/18.
//  Copyright © 2018 zeroGravity. All rights reserved.
//

import Foundation

import UIKit

class RadioButton: UIButton {
    var alternateButton:Array<RadioButton>?
    
    override func awakeFromNib() {
        self.layer.cornerRadius = 5
        self.layer.borderWidth = 2.0
        self.layer.masksToBounds = true
    }
    
    func unselectAlternateButtons(){
        if alternateButton != nil {
            self.isSelected = true
            
            for aButton:RadioButton in alternateButton! {
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
                self.layer.borderColor = UIColor(red:0.79, green:0.91, blue:0.96, alpha:1.0).cgColor
            } else {
                self.layer.borderColor = UIColor(red:0.89, green:0.91, blue:0.91, alpha:1.0).cgColor
            }
        }
    }
}
