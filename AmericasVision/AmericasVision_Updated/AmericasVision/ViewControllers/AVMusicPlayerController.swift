//
//  AVMusicPlayerController.swift
//  AmericasVision
//
//  Created by Mohan Dola on 22/08/18.
//  Copyright © 2018 zeroGravity. All rights reserved.
//

import Foundation
import AVFoundation

class MusicTrackTableCell:UITableViewCell{
    
    let albumImageView: UIImageView = {
        let view = UIImageView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.layer.cornerRadius = 15
        view.clipsToBounds = true
        return view
    }()
    
    let trackTitle: UILabel = {
        let label = UILabel()
        label.textColor = UIColor.black
        label.font = UIFont.systemFont(ofSize: 13)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        label.sizeToFit()
        label.textAlignment = .justified
        return label
    }()
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.addSubview(albumImageView)
        self.addSubview(trackTitle)
        
        albumImageView.leftAnchor.constraint(equalTo: leftAnchor, constant:10).isActive = true
        albumImageView.heightAnchor.constraint(equalToConstant:30).isActive = true
        albumImageView.widthAnchor.constraint(equalToConstant:30).isActive = true
        
        trackTitle.leftAnchor.constraint(equalTo: leftAnchor, constant:40).isActive = true
        trackTitle.widthAnchor.constraint(equalToConstant:self.frame.width-40).isActive = true
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
}
class AVMusicPlayerController: UIViewController {
    
    var albumId = String()
    var trackId = String()
    var tableView: UITableView = UITableView()

    let imageView : UIImageView = {
     let view = UIImageView()
     view.translatesAutoresizingMaskIntoConstraints = false
     view.image = UIImage(named: "Unknown")
     return view
    }()
    
    let trackTitle : UILabel = {
        let label = UILabel()
        label.text = "Rock On"
        label.textColor = UIColor.white
        label.font = UIFont.boldSystemFont(ofSize: 14)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let trackSubTitle : UILabel = {
        let label = UILabel()
        label.textColor = UIColor.white
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
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(MusicTrackTableCell.self, forCellReuseIdentifier: "MusicTrackTableCell")
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
        let backgroundImage = UIImageView(frame: UIScreen.main.bounds)
        backgroundImage.image = UIImage(named: "musicback.jpg")
        backgroundImage.contentMode = UIViewContentMode.scaleAspectFill
        self.view.insertSubview(backgroundImage, at: 0)
        
        self.view.addSubview(imageView)
        self.view.addSubview(trackTitle)
        self.view.addSubview(trackSubTitle)
        self.view.addSubview(progressBar)
        self.view.addSubview(backWardButton)
        self.view.addSubview(playButton)
        self.view.addSubview(forwardButton)
        
        playButton.addTarget(self,action: #selector(self.playAction(_:)),for: .touchUpInside)
        forwardButton.addTarget(self,action: #selector(self.pauseAction(_:)),for: .touchUpInside)
        backWardButton.addTarget(self,action: #selector(self.pauseAction(_:)),for: .touchUpInside)
        albumId = "test"
        if albumId.isEmpty {
        
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
        }else{
            self.view.addSubview(tableView)
            
            imageView.widthAnchor.constraint(equalToConstant: self.view.frame.width/3).isActive = true
            imageView.heightAnchor.constraint(equalToConstant: self.view.frame.width/3).isActive = true
            imageView.leftAnchor.constraint(equalTo: self.view.leftAnchor, constant: 10).isActive = true
            imageView.topAnchor.constraint(equalTo: self.view.topAnchor, constant: 10).isActive = true
            
            trackTitle.widthAnchor.constraint(equalToConstant: self.view.frame.width*2/3).isActive = true
            trackTitle.leftAnchor.constraint(equalTo: self.view.leftAnchor, constant: (self.view.frame.width/3)+10).isActive = true
            trackTitle.topAnchor.constraint(equalTo: self.view.topAnchor, constant: 10).isActive = true
            
            trackSubTitle.widthAnchor.constraint(equalToConstant: self.view.frame.width-60).isActive = true
            trackSubTitle.leftAnchor.constraint(equalTo: self.view.leftAnchor, constant: (self.view.frame.width/3)+10).isActive = true
            trackSubTitle.topAnchor.constraint(equalTo: self.view.topAnchor, constant: 30).isActive = true
            
            progressBar.leftAnchor.constraint(equalTo: self.view.leftAnchor, constant: 10).isActive = true
            progressBar.widthAnchor.constraint(equalToConstant: self.view.frame.width-20).isActive = true
            progressBar.heightAnchor.constraint(equalToConstant: 20).isActive = true
            progressBar.topAnchor.constraint(equalTo: self.view.topAnchor, constant:(self.view.frame.width/3)+10).isActive = true
            
            let buttonLeft = (self.view.frame.width/2)-150
            backWardButton.widthAnchor.constraint(equalToConstant: 50).isActive = true
            backWardButton.heightAnchor.constraint(equalToConstant: 50).isActive = true
            backWardButton.leftAnchor.constraint(equalTo: self.view.leftAnchor,constant:buttonLeft+50).isActive = true
            backWardButton.topAnchor.constraint(equalTo: self.view.topAnchor, constant: (self.view.frame.width/3)+30).isActive = true
            
            playButton.widthAnchor.constraint(equalToConstant: 50).isActive = true
            playButton.heightAnchor.constraint(equalToConstant: 50).isActive = true
            playButton.leftAnchor.constraint(equalTo: self.view.leftAnchor, constant:buttonLeft+120).isActive = true
            playButton.topAnchor.constraint(equalTo: self.view.topAnchor, constant: (self.view.frame.width/3)+30).isActive = true
            
            forwardButton.widthAnchor.constraint(equalToConstant: 50).isActive = true
            forwardButton.heightAnchor.constraint(equalToConstant: 50).isActive = true
            forwardButton.leftAnchor.constraint(equalTo: self.view.leftAnchor, constant: buttonLeft+190).isActive = true
            forwardButton.topAnchor.constraint(equalTo: self.view.topAnchor, constant: (self.view.frame.width/3)+30).isActive = true
            
            CommonUtils.addLineToView(view: forwardButton, position:.LINE_POSITION_BOTTOM, color: UIColor(red: 6/255, green: 90/255, blue: 1157/255, alpha: 1), width: 0.5)
        }
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

extension AVMusicPlayerController:UITableViewDataSource,UITableViewDelegate{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 4
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MusicTrackTableCell") as! MusicTrackTableCell
        cell.albumImageView.image = UIImage(named: "Unknown")
        cell.trackTitle.text = "Test"
        return cell
    }
    
    func tableView(_ tableView: UITableView,heightForRowAt indexPath: IndexPath) -> CGFloat{
        return 40
    }
    
}
