//
//  MusicPlayerButton.swift
//  AmericasVision
//
//  Created by Mohan Dola on 23/09/18.
//  Copyright © 2018 zeroGravity. All rights reserved.
//

import Foundation

class MusicFloatingPlayer :UIView {
    
    let backwardBtn: UIButton = {
        let menuButton = UIButton()
        menuButton.translatesAutoresizingMaskIntoConstraints = false
        return menuButton
    }()
    
    let playBtn: UIButton = {
        let menuButton = UIButton()
        menuButton.translatesAutoresizingMaskIntoConstraints = false
        return menuButton
    }()
    
    let forwardBtn: UIButton = {
        let menuButton = UIButton()
        menuButton.translatesAutoresizingMaskIntoConstraints = false
        return menuButton
    }()
    
    override  init(frame: CGRect) {
        super.init(frame: frame)
        self.addSubview(backwardBtn)
        self.addSubview(playBtn)
        self.addSubview(forwardBtn)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
