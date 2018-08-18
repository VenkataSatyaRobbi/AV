//
//  AVLabel.swift
//  AmericasVision
//
//  Created by Mohan Dola on 12/08/18.
//  Copyright © 2018 zeroGravity. All rights reserved.
//

import Foundation

import UIKit

class AVLabel : UILabel {

        var topInset:       CGFloat = 0
        var rightInset:     CGFloat = 0
        var bottomInset:    CGFloat = 0
        var leftInset:      CGFloat = 0
        
    override func drawText(in rect: CGRect) {
        var insets: UIEdgeInsets = UIEdgeInsets(top: self.topInset, left: self.leftInset, bottom: self.bottomInset, right: self.rightInset)
        self.setNeedsLayout()
        return super.drawText(in:UIEdgeInsetsInsetRect(rect, insets))
    }
   
}
