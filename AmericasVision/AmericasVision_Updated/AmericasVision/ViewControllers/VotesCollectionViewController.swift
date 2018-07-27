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


class VoteCell: UICollectionViewCell{
    
    let header: UILabel = {
        let label = UILabel()
        label.textColor = UIColor.white
        label.font = UIFont.boldSystemFont(ofSize: 14)
        label.text = "Democratic Party"
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let viewfooter: UIView = {
        let viewfooter = UIView()
        viewfooter.backgroundColor = UIColor.black
        viewfooter.translatesAutoresizingMaskIntoConstraints = false
        return viewfooter
    }()
    
    let headerView: UIView = {
        let headerView = UIView()
        headerView.backgroundColor = UIColor.black
        headerView.translatesAutoresizingMaskIntoConstraints = false
        return headerView
    }()
   
    
    let imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "image.jpg")
        imageView.layer.cornerRadius = 30
        imageView.layer.masksToBounds = true
        imageView.translatesAutoresizingMaskIntoConstraints = false
        
        return imageView
    }()
    
    let partyflagView: UIImageView = {
        let partyflagView = UIImageView()
        partyflagView.image = UIImage(named: "democrat")
        partyflagView.translatesAutoresizingMaskIntoConstraints = false
       
        return partyflagView
    }()
    let footer: UILabel = {
        let label = UILabel()
        label.textColor = UIColor.white
        label.font = UIFont.boldSystemFont(ofSize: 14)
        label.text = "Trump               Votes 46"
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = UIColor.white
        headerView.addSubview(header)
        addSubview(headerView)
        addSubview(imageView)
        addSubview(partyflagView)
        viewfooter.addSubview(footer)
        addSubview(viewfooter)
        
        
       
        
        headerView.leftAnchor.constraint(equalTo: leftAnchor, constant:0).isActive = true
        headerView.topAnchor.constraint(equalTo: topAnchor, constant:0).isActive = true
        headerView.heightAnchor.constraint(equalToConstant:36).isActive = true
        headerView.widthAnchor.constraint(equalToConstant:self.frame.width).isActive = true
        
       
        
        header.leftAnchor.constraint(equalTo: leftAnchor, constant:0).isActive = true
        header.topAnchor.constraint(equalTo: topAnchor, constant:0).isActive = true
        header.heightAnchor.constraint(equalToConstant:36).isActive = true
        header.widthAnchor.constraint(equalToConstant: self.frame.width).isActive = true

        
        
        imageView.leftAnchor.constraint(equalTo: leftAnchor, constant: 3).isActive = true
        imageView.topAnchor.constraint(equalTo: topAnchor, constant: 60).isActive = true
        imageView.heightAnchor.constraint(equalToConstant:60).isActive = true
        imageView.widthAnchor.constraint(equalToConstant: 60).isActive = true
        
        
        partyflagView.rightAnchor.constraint(equalTo: rightAnchor, constant:-3).isActive = true
        partyflagView.topAnchor.constraint(equalTo: topAnchor, constant: 60).isActive = true
        partyflagView.heightAnchor.constraint(equalToConstant:60).isActive = true
        partyflagView.widthAnchor.constraint(equalToConstant:70).isActive = true
        
        
        viewfooter.leftAnchor.constraint(equalTo: leftAnchor, constant: 0).isActive = true
        viewfooter.topAnchor.constraint(equalTo: topAnchor, constant: 140).isActive = true
        viewfooter.heightAnchor.constraint(equalToConstant:36).isActive = true
        viewfooter.widthAnchor.constraint(equalToConstant: self.frame.width).isActive = true
        
        footer.leftAnchor.constraint(equalTo: leftAnchor, constant: 0).isActive = true
        footer.topAnchor.constraint(equalTo: topAnchor, constant: 140).isActive = true
        footer.heightAnchor.constraint(equalToConstant:36).isActive = true
        footer.widthAnchor.constraint(equalToConstant:self.frame.width).isActive = true

        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init code vote cell")
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }
    
}

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
        
        self.collectionView?.backgroundColor = UIColor.groupTableViewBackground
        
        layout.sectionInset = UIEdgeInsets(top: 20, left: 10, bottom: 10, right: 10)
        let cellwidth = Int(self.view.frame.width - 30)/count
        let cellHeight = Int(self.view.frame.height - 380)/count
        layout.itemSize = CGSize(width: cellwidth, height: cellHeight)

        self.collectionView?.collectionViewLayout = layout
        //  Register cell classes
        self.collectionView!.register(VoteCell.self, forCellWithReuseIdentifier: reuseIdentifier)
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
        
        
      //  cell.backgroundColor = UIColor.groupTableViewBackground
      
//        cell.backgroundColor = UIColor.brown
//        if indexPath.row == 1 {
//
//
//
//        }
        
//

       
        
        return cell
        
    }
    
}

