//
//  VotesCollectionViewController.swift
//  AmericasVision
//
//  Created by Venkata Satya R Robbi on 5/5/18.
//  Copyright © 2018 zeroGravity. All rights reserved.
//

import UIKit
import Charts

private let reuseIdentifier = "voteCell"

class VotesCollectionViewController: UICollectionViewController {
    
    @IBOutlet weak var VotesHomeButton: UIBarButtonItem!
    private let count = 2
    var chart: LineChartView!
    var ddataSet: LineChartDataSet!
    var rdataSet: LineChartDataSet!
    
    let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
    
    var collectionData = ["23","24"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // let flagImageView = UIImageView(frame:  CGRect(x:10, y: -30, width: 395 , height: 300
        // ))
        
        
        layout.sectionInset = UIEdgeInsets(top: 20, left: 10, bottom: 10, right: 10)
        let cellwidth = Int(self.view.frame.width - 30)/count
        let cellHeight = Int(self.view.frame.height - 380)/count
        layout.itemSize = CGSize(width: cellwidth, height: cellHeight)
        
        self.collectionView?.collectionViewLayout = layout
        //  Register cell classes
        self.collectionView!.register(UICollectionViewCell.self, forCellWithReuseIdentifier: reuseIdentifier)
        lineChart()
        sideMenus()
    }
    
    func lineChart(){
        let dvalues: [Double] = [8, 40, 20, 59, 52, 44, 30, 20, 75]
        var dentries: [ChartDataEntry] = Array()
        
        for (i, value) in dvalues.enumerated()
        {
            dentries.append(ChartDataEntry(x: Double(i), y: value, icon: UIImage(named: "icon", in: Bundle(for: self.classForCoder), compatibleWith: nil)))
        }
        
        let rvalues: [Double] = [18, 14, 61, 43, 22, 24, 57, 21, 55]
        var rentries: [ChartDataEntry] = Array()
        
        for (i, value) in rvalues.enumerated()
        {
            rentries.append(ChartDataEntry(x: Double(i), y: value, icon: UIImage(named: "icon", in: Bundle(for: self.classForCoder), compatibleWith: nil)))
        }
        
        ddataSet = LineChartDataSet(values: dentries, label: "Democratic Party")
        ddataSet.drawIconsEnabled = false
        ddataSet.iconsOffset = CGPoint(x: 0, y: 10.0)
        
        rdataSet = LineChartDataSet(values: rentries, label: "Republican Party")
        rdataSet.drawIconsEnabled = false
        rdataSet.iconsOffset = CGPoint(x: 0, y: 10.0)
        
        chart = LineChartView(frame: CGRect(x: 0, y: 250, width: 480, height: 350))
        chart.backgroundColor = NSUIColor.clear
        chart.leftAxis.axisMinimum = 0.0
        chart.rightAxis.axisMinimum = 0.0
        chart.data = LineChartData(dataSet: rdataSet)
        chart.data?.addDataSet(ddataSet)
        self.collectionView?.addSubview(chart)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        sideMenus()
    }
    
    func sideMenus(){
        if revealViewController() != nil {
            VotesHomeButton.target = revealViewController()
            VotesHomeButton.action = #selector(SWRevealViewController.revealToggle(_:))
            revealViewController().rearViewRevealWidth = 260
            view.addGestureRecognizer(self.revealViewController().panGestureRecognizer())
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath)
        cell.backgroundColor = UIColor.white
       
        switch  indexPath.item {
        case 0:
            //   let imgView = UIImageView(frame:  CGRect(x: 0, y: 0, width: layout.itemSize.width , height: layout.itemSize.height))
            let imgView = UIImageView(frame:  CGRect(x:90, y:28, width: 100, height:100))
            imgView.contentMode = .scaleAspectFit
            imgView.image = UIImage(named: "democrat")
            imgView.clipsToBounds = true
            imgView.layer.cornerRadius = 10
            
            var dynamicLabel: UILabel = UILabel()
            dynamicLabel = UILabel(frame:  CGRect(x:1, y:0, width:185, height:35))
            dynamicLabel.textColor = UIColor.gray
            dynamicLabel.layer.cornerRadius = 10
            dynamicLabel.textAlignment = NSTextAlignment.center
            dynamicLabel.text = "Democratic Party"
            // imgView.addSubview(dynamicLabel)
            cell.contentView.addSubview(dynamicLabel)
            
            
            var dynamicLabel1: UILabel = UILabel()
            dynamicLabel1 = UILabel(frame:  CGRect(x:5, y:140, width:100, height:35))
            //dynamicLabel1.backgroundColor = UIColor.white
            dynamicLabel1.textColor = UIColor.white
            dynamicLabel1.layer.cornerRadius = 10
            dynamicLabel1.textAlignment = NSTextAlignment.left
            dynamicLabel1.text = "Party"
            cell.contentView.addSubview(dynamicLabel1)
            
            var dynamicLabel2: UILabel = UILabel()
            dynamicLabel2 = UILabel(frame:  CGRect(x:90, y:140, width:100, height:35))
            dynamicLabel2.textColor = UIColor.white
            dynamicLabel2.layer.cornerRadius = 10
            dynamicLabel2.textAlignment = NSTextAlignment.left
            dynamicLabel2.text = "Votes"
            cell.contentView.addSubview(dynamicLabel2)
            
            // imgView.addSubview(dynamicLabel1)
            
            let imgView1 = UIImageView(frame:  CGRect(x: 2, y:20, width: 80, height:100))
            imgView1.contentMode = .scaleAspectFit
            imgView1.layer.cornerRadius = 10.0
            imgView1.clipsToBounds = true
            imgView1.image = UIImage(named: "profile")
            //imgView.addSubview(imgView1)
            cell.contentView.addSubview(imgView1)
            cell.layer.cornerRadius = 10
            cell.contentView.addSubview(imgView)
        case 1:
            // let imgView = UIImageView(frame:  CGRect(x: 0, y: 0, width: layout.itemSize.width , height: layout.itemSize.height))
            
            let imgView = UIImageView(frame:  CGRect(x:90, y:28, width: 100, height:100))
            imgView.contentMode = .scaleAspectFit
            imgView.image = UIImage(named: "democrat")
            imgView.clipsToBounds = true
            imgView.layer.cornerRadius = 10
            
            
            var dynamicLabel: UILabel = UILabel()
            dynamicLabel = UILabel(frame:  CGRect(x:1, y:0, width:185, height:35))
            //dynamicLabel.backgroundColor = UIColor.white
            dynamicLabel.textColor = UIColor.gray
            dynamicLabel.layer.cornerRadius = 10
            dynamicLabel.textAlignment = NSTextAlignment.center
            dynamicLabel.text = "Republican Party"
            //imgView.addSubview(dynamicLabel)
            cell.contentView.addSubview(dynamicLabel)
            
            
            var dynamicLabel1: UILabel = UILabel()
            dynamicLabel1 = UILabel(frame:  CGRect(x:5, y:140, width:100, height:35))
            //dynamicLabel1.backgroundColor = UIColor.white
            dynamicLabel1.textColor = UIColor.white
            dynamicLabel1.layer.cornerRadius = 10
            dynamicLabel1.textAlignment = NSTextAlignment.left
            dynamicLabel1.text = "Repblican"
            cell.contentView.addSubview(dynamicLabel1)
            
            var dynamicLabel2: UILabel = UILabel()
            dynamicLabel2 = UILabel(frame:  CGRect(x:90, y:140, width:100, height:35))
            dynamicLabel2.textColor = UIColor.white
            dynamicLabel2.layer.cornerRadius = 10
            dynamicLabel2.textAlignment = NSTextAlignment.left
            dynamicLabel2.text = "Votes"
            cell.contentView.addSubview(dynamicLabel2)
            
            
            
            let imgView1 = UIImageView(frame:  CGRect(x: 2, y:20, width: 80, height:100))
            imgView1.contentMode = .scaleAspectFit
            imgView1.layer.cornerRadius = 10.0
            imgView1.clipsToBounds = true
            imgView1.image = UIImage(named: "profile")
            cell.contentView.addSubview(imgView1)
            //imgView.addSubview(imgView1)
            
            cell.layer.cornerRadius = 10
            cell.contentView.addSubview(imgView)
        default:
            cell.contentView.addSubview(UIImageView(image: UIImage(named: "lanscape")))
        }
        
        
        
        self.collectionView?.backgroundColor = UIColor.groupTableViewBackground
        
        
        //      let imgView = UIImageView(frame:  CGRect(x: 0, y: 0, width: layout.itemSize.width , height: layout.itemSize.height))
        //      imgView.contentMode = .scaleAspectFit
        //      imgView.image = UIImage(named: "image.jpg")
        //      imgView.clipsToBounds = true
        //
        //      var dynamicLabel: UILabel = UILabel()
        //      dynamicLabel = UILabel(frame:  CGRect(x:3, y:2, width:185, height:35))
        //      //dynamicLabel.backgroundColor = UIColor.white
        //      dynamicLabel.textColor = UIColor.white
        //       dynamicLabel.layer.cornerRadius = 10
        //      dynamicLabel.textAlignment = NSTextAlignment.center
        //      dynamicLabel.text = "Democrat Party "
        //      imgView.addSubview(dynamicLabel)
        //
        //
        //      var dynamicLabel1: UILabel = UILabel()
        //      dynamicLabel1 = UILabel(frame:  CGRect(x:4, y:140, width:190, height:35))
        //      //dynamicLabel1.backgroundColor = UIColor.white
        //      dynamicLabel1.textColor = UIColor.white
        //      dynamicLabel1.layer.cornerRadius = 10
        //      dynamicLabel1.textAlignment = NSTextAlignment.center
        //      dynamicLabel1.text = "Candidate name "
        //
        //      imgView.addSubview(dynamicLabel1)
        //
        //      let imgView1 = UIImageView(frame:  CGRect(x: 0, y:38, width: 100, height:100))
        //      imgView1.contentMode = .scaleAspectFit
        //      imgView1.layer.cornerRadius = 50.0
        //      imgView1.clipsToBounds = true
        //      imgView1.image = UIImage(named: "profile")
        //      imgView.addSubview(imgView1)
        //
        //      cell.layer.cornerRadius = 10
        //      cell.contentView.addSubview(imgView)
        
        
        return cell
        
    }
    
}

