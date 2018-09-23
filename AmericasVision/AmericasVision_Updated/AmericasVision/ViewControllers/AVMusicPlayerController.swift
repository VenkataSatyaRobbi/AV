//
//  AVMusicPlayerController.swift
//  AmericasVision
//
//  Created by Mohan Dola on 22/08/18.
//  Copyright © 2018 zeroGravity. All rights reserved.
//

import Foundation
import AVFoundation

class AVMusicPlayerController: UIViewController {
    
    var albumId = String()
    var trackId = String()
   
    let imageView : UIImageView = {
     let view = UIImageView()
     view.translatesAutoresizingMaskIntoConstraints = false
     view.image = UIImage(named: "Unknown")
     view.layer.shadowColor = UIColor.black.cgColor
     view.layer.shadowOffset = CGSize(width: 0, height: 0.5)
     view.layer.shadowRadius = 0.5
     view.layer.shadowOpacity = 0.5
     view.layer.masksToBounds = false
     view.layer.shadowPath = UIBezierPath(roundedRect: view.layer.bounds, cornerRadius: view.layer.cornerRadius).cgPath
    
     return view
    }()
    
    let trackTitle : UILabel = {
        let label = UILabel()
        label.text = "Rock On"
        label.textColor = UIColor.black
        label.font = UIFont.boldSystemFont(ofSize: 14)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let trackSubTitle : UILabel = {
        let label = UILabel()
        label.textColor = UIColor.darkGray
        label.font = UIFont.boldSystemFont(ofSize: 12)
        label.text = "Farhan Akhtar,Arujun Rampal,Prachi Desai"
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let progressBar : UISlider = {
        let slider = UISlider()
        slider.translatesAutoresizingMaskIntoConstraints = false
        return slider
    }()
    
    let playButton : UIButton = {
       let button =  UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        let image = UIImage(named: "playMusic")
        button.setBackgroundImage(image, for: .normal)
        return button
    }()
    
    let forwardButton : UIButton = {
        let button =  UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        let image = UIImage(named: "forwardMusic")
        button.setBackgroundImage(image, for: .normal)
        return button
    }()
    
    let backWardButton : UIButton = {
        let button =  UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        let image = UIImage(named: "backwardMusic")
        button.setBackgroundImage(image, for: .normal)
        return button
    }()
    
    var player = AVAudioPlayer()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        do {
            player =  try AVAudioPlayer(contentsOf: URL.init(fileURLWithPath: Bundle.main.path(forResource: "test", ofType: "mp3")!))
            player.prepareToPlay()
            var audioSession = AVAudioSession.sharedInstance()
            do{
                try audioSession.setCategory(AVAudioSessionCategoryPlayback)
            }
        } catch  {
            print("error")
        }
        
        if !albumId.isEmpty {
            
        }
     
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.view.addSubview(imageView)
        self.view.addSubview(trackTitle)
        self.view.addSubview(trackSubTitle)
        self.view.addSubview(progressBar)
        self.view.addSubview(backWardButton)
        self.view.addSubview(playButton)
        self.view.addSubview(forwardButton)
        self.view.backgroundColor = UIColor.white
        
        playButton.addTarget(self,action: #selector(self.playAction(_:)),for: .touchUpInside)
        forwardButton.addTarget(self,action: #selector(self.pauseAction(_:)),for: .touchUpInside)
        backWardButton.addTarget(self,action: #selector(self.pauseAction(_:)),for: .touchUpInside)
        
        imageView.widthAnchor.constraint(equalToConstant: self.view.frame.width - 60).isActive = true
        imageView.heightAnchor.constraint(equalToConstant: self.view.frame.height/2).isActive = true
        imageView.leftAnchor.constraint(equalTo: self.view.leftAnchor, constant: 30).isActive = true
        imageView.topAnchor.constraint(equalTo: self.view.topAnchor, constant: 80).isActive = true
        
        trackTitle.widthAnchor.constraint(equalToConstant: self.view.frame.width-60).isActive = true
        trackTitle.leftAnchor.constraint(equalTo: self.view.leftAnchor, constant: 30).isActive = true
        trackTitle.heightAnchor.constraint(equalToConstant: 30).isActive = true
        trackTitle.topAnchor.constraint(equalTo: self.view.topAnchor, constant: (self.view.frame.height/2)+80).isActive = true
        trackTitle.textAlignment = .center
        
        trackSubTitle.widthAnchor.constraint(equalToConstant: self.view.frame.width-60).isActive = true
        trackSubTitle.leftAnchor.constraint(equalTo: self.view.leftAnchor, constant: 30).isActive = true
        trackSubTitle.heightAnchor.constraint(equalToConstant: 30).isActive = true
        trackSubTitle.topAnchor.constraint(equalTo: self.view.topAnchor, constant: (self.view.frame.height/2)+110).isActive = true
        trackSubTitle.textAlignment = .center
        
        progressBar.leftAnchor.constraint(equalTo: self.view.leftAnchor, constant: 30).isActive = true
        progressBar.widthAnchor.constraint(equalToConstant: self.view.frame.width-60).isActive = true
        progressBar.heightAnchor.constraint(equalToConstant: 30).isActive = true
        progressBar.topAnchor.constraint(equalTo: self.view.topAnchor, constant:( self.view.frame.height/2)+140).isActive = true
        
        let buttonLeft = (self.view.frame.width/2)-150
        backWardButton.widthAnchor.constraint(equalToConstant: 50).isActive = true
        backWardButton.heightAnchor.constraint(equalToConstant: 50).isActive = true
        backWardButton.leftAnchor.constraint(equalTo: self.view.leftAnchor,constant:buttonLeft+50).isActive = true
        backWardButton.topAnchor.constraint(equalTo: self.view.topAnchor, constant: (self.view.frame.height/2)+170).isActive = true
        
        playButton.widthAnchor.constraint(equalToConstant: 50).isActive = true
        playButton.heightAnchor.constraint(equalToConstant: 50).isActive = true
        playButton.leftAnchor.constraint(equalTo: self.view.leftAnchor, constant:buttonLeft+120).isActive = true
        playButton.topAnchor.constraint(equalTo: self.view.topAnchor, constant: (self.view.frame.height/2)+170).isActive = true
        
        forwardButton.widthAnchor.constraint(equalToConstant: 50).isActive = true
        forwardButton.heightAnchor.constraint(equalToConstant: 50).isActive = true
        forwardButton.leftAnchor.constraint(equalTo: self.view.leftAnchor, constant: buttonLeft+190).isActive = true
        forwardButton.topAnchor.constraint(equalTo: self.view.topAnchor, constant: (self.view.frame.height/2)+170).isActive = true
        
    }
    
    @IBAction func playAction(_ sender: UIButton) {
        let image = UIImage(named: "pauseMusic")
        playButton.setBackgroundImage(image, for: .normal)
        player.play()
    }
    
    @IBAction func pauseAction(_ sender: UIButton) {
        if player.isPlaying {
            let image = UIImage(named: "playMusic")
            playButton.setBackgroundImage(image, for: .normal)
            player.pause()
        }
    }
   
}
