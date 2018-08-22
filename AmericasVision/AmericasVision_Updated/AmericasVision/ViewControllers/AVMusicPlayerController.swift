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

    let imageView : UIImageView = {
     let view = UIImageView()
     view.translatesAutoresizingMaskIntoConstraints = false
     view.image = UIImage(named: "Unknown")
     return view
    }()
    
    let trackTitle : UILabel = {
        let label = UILabel()
        label.text = "Rock On"
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
        button.setTitle("Play", for: .normal)
        button.backgroundColor = UIColor.blue
        button.titleLabel?.textColor = UIColor.white
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    let pauseButton : UIButton = {
        let button =  UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
         button.setTitle("Pause", for: .normal)
        button.titleLabel?.textColor = UIColor.white
        button.backgroundColor = UIColor.blue
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
     
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.view.addSubview(imageView)
        self.view.addSubview(trackTitle)
        self.view.addSubview(progressBar)
        self.view.addSubview(playButton)
        self.view.addSubview(pauseButton)
        
        playButton.addTarget(self,action: #selector(self.playAction(_:)),for: .touchUpInside)
        pauseButton.addTarget(self,action: #selector(self.pauseAction(_:)),for: .touchUpInside)
        imageView.widthAnchor.constraint(equalToConstant: self.view.frame.width).isActive = true
        imageView.heightAnchor.constraint(equalToConstant: self.view.frame.height/2).isActive = true
        imageView.topAnchor.constraint(equalTo: self.view.topAnchor, constant: 5).isActive = true
        
        trackTitle.widthAnchor.constraint(equalToConstant: self.view.frame.width).isActive = true
        trackTitle.heightAnchor.constraint(equalToConstant: 30).isActive = true
        trackTitle.topAnchor.constraint(equalTo: self.view.topAnchor, constant: self.view.frame.height/2).isActive = true
        
        progressBar.widthAnchor.constraint(equalToConstant: self.view.frame.width).isActive = true
        progressBar.heightAnchor.constraint(equalToConstant: 30).isActive = true
        progressBar.topAnchor.constraint(equalTo: self.view.topAnchor, constant:( self.view.frame.height/2)+30).isActive = true
        
        playButton.widthAnchor.constraint(equalToConstant: 50).isActive = true
        playButton.heightAnchor.constraint(equalToConstant: 30).isActive = true
        playButton.leftAnchor.constraint(equalTo: self.view.leftAnchor, constant: (self.view.frame.width/2)-25).isActive = true
        playButton.topAnchor.constraint(equalTo: self.view.topAnchor, constant: (self.view.frame.height/2)+80).isActive = true
        
        pauseButton.widthAnchor.constraint(equalToConstant: 50).isActive = true
        pauseButton.heightAnchor.constraint(equalToConstant: 30).isActive = true
        pauseButton.leftAnchor.constraint(equalTo: self.view.leftAnchor, constant: (self.view.frame.width/2)+30).isActive = true
        pauseButton.topAnchor.constraint(equalTo: self.view.topAnchor, constant: (self.view.frame.height/2)+80).isActive = true
        
    }
    
    @IBAction func playAction(_ sender: UIButton) {
        player.play()
    }
    
    @IBAction func pauseAction(_ sender: UIButton) {
        if player.isPlaying {
            player.pause()
        }
    }
   
}
