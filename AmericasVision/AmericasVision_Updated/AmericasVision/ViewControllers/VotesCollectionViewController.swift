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
        label.textColor = UIColor.black
        label.font = UIFont.boldSystemFont(ofSize: 14)
        label.text = "Opinion poll"
        label.textAlignment = .left
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let viewfooter: UIView = {
        let viewfooter = UIView()
        viewfooter.backgroundColor = UIColor(red:0.80, green:0.83, blue:0.83, alpha:1.0)
        viewfooter.translatesAutoresizingMaskIntoConstraints = false
        return viewfooter
    }()
    
    let headerView: UIView = {
        let headerView = UIView()
        headerView.backgroundColor = UIColor(red:0.79, green:0.91, blue:0.96, alpha:1.0)
        headerView.translatesAutoresizingMaskIntoConstraints = false
        return headerView
    }()
   
    let question: UILabel = {
        let label = UILabel()
        label.textColor = UIColor.black
        label.font = UIFont.boldSystemFont(ofSize: 14)
        label.text = "Do you think India will lose its IT edge in the era of AI?"
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    
    let footer: UILabel = {
        let label = UILabel()
        label.textColor = UIColor.white
        label.font = UIFont.boldSystemFont(ofSize: 14)
        label.text = "Yes: 20 , No : 30  ,Can't say : 5"
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = UIColor.white
        headerView.addSubview(header)
        addSubview(headerView)
        addSubview(question)
        viewfooter.addSubview(footer)
        addSubview(viewfooter)
        
        headerView.leftAnchor.constraint(equalTo: leftAnchor, constant:0).isActive = true
        headerView.topAnchor.constraint(equalTo: topAnchor, constant:0).isActive = true
        headerView.heightAnchor.constraint(equalToConstant:32).isActive = true
        headerView.widthAnchor.constraint(equalToConstant:self.frame.width).isActive = true
        header.leftAnchor.constraint(equalTo: leftAnchor, constant:5).isActive = true
        header.topAnchor.constraint(equalTo: topAnchor, constant:0).isActive = true
        header.heightAnchor.constraint(equalToConstant:32).isActive = true
        header.widthAnchor.constraint(equalToConstant: self.frame.width).isActive = true

        question.leftAnchor.constraint(equalTo: leftAnchor, constant: 5).isActive = true
        question.topAnchor.constraint(equalTo: topAnchor, constant: 0).isActive = true
        question.heightAnchor.constraint(equalToConstant:168).isActive = true
        question.widthAnchor.constraint(equalToConstant: self.frame.width).isActive = true
        
        viewfooter.leftAnchor.constraint(equalTo: leftAnchor, constant: 0).isActive = true
        viewfooter.topAnchor.constraint(equalTo: topAnchor, constant: 200).isActive = true
        viewfooter.heightAnchor.constraint(equalToConstant:32).isActive = true
        viewfooter.widthAnchor.constraint(equalToConstant: self.frame.width).isActive = true
        footer.leftAnchor.constraint(equalTo: leftAnchor, constant: 0).isActive = true
        footer.topAnchor.constraint(equalTo: topAnchor, constant: 200).isActive = true
        footer.heightAnchor.constraint(equalToConstant:32).isActive = true
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
    private let count = 1
    
    let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
    
    var collectionData = ["23","24"]
    
    lazy var pieChart: PieChartView = {
        let p = PieChartView()
        p.translatesAutoresizingMaskIntoConstraints = false
        p.noDataText = "No date to display"
        p.legend.enabled = false
        p.chartDescription?.text = ""
        p.drawHoleEnabled = false
        //p.delegate = self
        return p
    }()
    
    let surveyData = ["Yes": 20, "No": 30, "Can't say": 5]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.collectionView?.backgroundColor = UIColor.groupTableViewBackground
        
        layout.sectionInset = UIEdgeInsets(top: 20, left: 10, bottom: 10, right: 10)
        let cellwidth = Int(self.view.frame.width - 30)
        let cellHeight = Int(self.view.frame.height - 40)/3
        print("cell----------------------")
        print(cellHeight)
        layout.itemSize = CGSize(width: cellwidth, height: cellHeight)

        self.collectionView?.collectionViewLayout = layout
        //  Register cell classes
        self.collectionView!.register(VoteCell.self, forCellWithReuseIdentifier: reuseIdentifier)
        pieChartSetup()
        sideMenus()
    }
    
    func pieChartSetup(){
        setupPieChart()
        fillChart()
    }
    
    func setupPieChart() {
        pieChart.setExtraOffsets (left: -15.0, top: 120.0, right:-15.0, bottom: 0.0)
        self.collectionView?.addSubview(pieChart)
        pieChart.centerXAnchor.constraint(equalTo: view.centerXAnchor, constant: 0).isActive = true
        pieChart.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: 0).isActive = true
        pieChart.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 1).isActive = true
        pieChart.heightAnchor.constraint(equalTo: view.widthAnchor, multiplier: 1).isActive = true
    }
    
    func fillChart() {
        var dataEntries = [PieChartDataEntry]()
        for (key, val) in surveyData {
            let percent = Double(val) / 100.0
            let entry = PieChartDataEntry(value: percent, label: key)
            dataEntries.append(entry)
        }
        let chartDataSet = PieChartDataSet(values: dataEntries, label: "")
        chartDataSet.colors = ChartColorTemplates.material()
        chartDataSet.sliceSpace = 2
        chartDataSet.selectionShift = 5
        
        let chartData = PieChartData(dataSet: chartDataSet)
        let formatter = NumberFormatter()
        formatter.numberStyle = .percent
        formatter.maximumFractionDigits = 0
        chartData.setValueFormatter(DefaultValueFormatter(formatter: formatter))
        
        pieChart.data = chartData
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
        return 1
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath)
        //cell.backgroundColor = UIColor.white
        return cell
        
    }
    
}

