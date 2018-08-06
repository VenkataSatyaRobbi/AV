//
//  VotesCollectionViewController.swift
//  AmericasVision
//
//  Created by Venkata Satya R Robbi on 5/5/18.
//  Copyright © 2018 zeroGravity. All rights reserved.
//

import UIKit
import Charts
import FirebaseDatabase

private let reuseIdentifier = "voteCell"

class VoteCell: UICollectionViewCell{
  
    
    let header: UILabel = {
        let label = UILabel()
        label.textColor = UIColor.black
        label.font = UIFont.boldSystemFont(ofSize: 14)
        label.text = "Opinion poll"
        label.textAlignment = .center
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
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    let optionOne: UILabel = {
        let label = UILabel()
        label.textColor = UIColor.black
        label.font = UIFont.boldSystemFont(ofSize: 14)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let optionTwo: UILabel = {
        let label = UILabel()
        label.textColor = UIColor.black
        label.font = UIFont.boldSystemFont(ofSize: 14)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let OptionThree: UILabel = {
        let label = UILabel()
        label.textColor = UIColor.black
        label.font = UIFont.boldSystemFont(ofSize: 14)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    
    let footer: UILabel = {
        let label = UILabel()
        label.textColor = UIColor.white
        label.font = UIFont.boldSystemFont(ofSize: 14)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
//    let option1Radio: UIButton = {
//        let radioButton = RadioButton()
//        radioButton.isSelected = true
//        radioButton.translatesAutoresizingMaskIntoConstraints = false
//       return radioButton
//    }()
//
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
   
    override init(frame: CGRect) {
        
        super.init(frame: frame)
        backgroundColor = UIColor.white
        headerView.addSubview(header)
        self.addSubview(headerView)
        self.addSubview(self.question)
        self.addSubview(optionOne)
        //self.addSubview(option1Radio)
        self.addSubview(optionTwo)
        self.addSubview(OptionThree)
        viewfooter.addSubview(footer)
        self.addSubview(viewfooter)
        pieChartSetup()
    
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
        
//        option1Radio.leftAnchor.constraint(equalTo: leftAnchor, constant: 5).isActive = true
//        option1Radio.topAnchor.constraint(equalTo: topAnchor, constant: 10).isActive = true
//        option1Radio.heightAnchor.constraint(equalToConstant:500).isActive = true
//        option1Radio.widthAnchor.constraint(equalToConstant: self.frame.width).isActive = true
//
        optionOne.leftAnchor.constraint(equalTo: leftAnchor, constant: 5).isActive = true
        optionOne.topAnchor.constraint(equalTo: topAnchor, constant: 0).isActive = true
        optionOne.heightAnchor.constraint(equalToConstant:230).isActive = true
        optionOne.widthAnchor.constraint(equalToConstant: self.frame.width).isActive = true
        
        optionTwo.leftAnchor.constraint(equalTo: leftAnchor, constant: 5).isActive = true
        optionTwo.topAnchor.constraint(equalTo: topAnchor, constant: 0).isActive = true
        optionTwo.heightAnchor.constraint(equalToConstant:260).isActive = true
        optionTwo.widthAnchor.constraint(equalToConstant: self.frame.width).isActive = true
        
        OptionThree.leftAnchor.constraint(equalTo: leftAnchor, constant: 5).isActive = true
        OptionThree.topAnchor.constraint(equalTo: topAnchor, constant: 0).isActive = true
        OptionThree.heightAnchor.constraint(equalToConstant:290).isActive = true
        OptionThree.widthAnchor.constraint(equalToConstant: self.frame.width).isActive = true
        
        viewfooter.leftAnchor.constraint(equalTo: leftAnchor, constant: 0).isActive = true
        viewfooter.topAnchor.constraint(equalTo: topAnchor, constant: 300).isActive = true
        viewfooter.heightAnchor.constraint(equalToConstant:32).isActive = true
        viewfooter.widthAnchor.constraint(equalToConstant: self.frame.width).isActive = true
        footer.leftAnchor.constraint(equalTo: leftAnchor, constant: 0).isActive = true
        footer.topAnchor.constraint(equalTo: topAnchor, constant: 300).isActive = true
        footer.heightAnchor.constraint(equalToConstant:32).isActive = true
        footer.widthAnchor.constraint(equalToConstant:self.frame.width).isActive = true
     
    }
    
    func pieChartSetup(){
        setupPieChart()
        fillChart()
    }
    
    func setupPieChart() {
        pieChart.setExtraOffsets (left: -15.0, top: 120.0, right:-15.0, bottom: 0.0)
        addSubview(pieChart)
        pieChart.centerXAnchor.constraint(equalTo: centerXAnchor, constant: 0).isActive = true
        pieChart.centerYAnchor.constraint(equalTo: centerYAnchor, constant: 0).isActive = true
        pieChart.widthAnchor.constraint(equalTo: widthAnchor, multiplier: 1).isActive = true
        pieChart.heightAnchor.constraint(equalTo: widthAnchor, multiplier: 1).isActive = true
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
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init code vote cell")
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
}

class VotesCollectionViewController: UICollectionViewController{
    
    @IBOutlet weak var VotesHomeButton: UIBarButtonItem!
    private let count = 1
    
    let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
    
    var collectionData = ["23","24"]
    
    var opinion = [Opinion]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.collectionView?.backgroundColor = UIColor.groupTableViewBackground
      
        layout.sectionInset = UIEdgeInsets(top: 20, left: 10, bottom: 10, right: 10)
        let cellwidth = Int(self.view.frame.width - 30)
        let cellHeight = Int(self.view.frame.height - 40)/3
        layout.itemSize = CGSize(width: cellwidth, height: cellHeight)
        
        fetchFirstOpinion()
        self.collectionView?.collectionViewLayout = layout
        //  Register cell classes
        collectionView!.register(VoteCell.self, forCellWithReuseIdentifier: "cell")
        collectionView?.dataSource = self
        collectionView?.delegate = self
        sideMenus()
    }
    
    func fetchFirstOpinion(){
        DBProvider.instance.opinionRef.queryOrdered(byChild: "Date").queryLimited(toFirst: 1).observe(.childAdded)
            //queryOrdered(byChild: "Date").observe(.childAdded)
        { (snapshot: DataSnapshot) in
            if let dict = snapshot.value as? [String: Any] {
                let question = dict["Question"] as! String
                let option1 = dict["Option1"] as! String
                let option2 = dict["Option2"] as! String
                let option3 = dict["Option3"] as! String
                let count1 = dict["Count1"] as! NSNumber
                let count2 = dict["Count2"] as! NSNumber
                let count3 = dict["Count3"] as! NSNumber
                //let publishDate = dict["Date"] as! Date
                let data = Opinion.init(question: question, option1: option1, option2: option2, option3: option3, publishDate: Date(),count1: count1,count2: count2,count3: count3)
                self.opinion.append(data)
                self.collectionView?.reloadData()
            }
            
        }
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
        return opinion.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! VoteCell
        
        cell.question.text = opinion[indexPath.row].question
        cell.optionOne.text = opinion[indexPath.row].option1
        cell.optionTwo.text = opinion[indexPath.row].option2
        cell.OptionThree.text = opinion[indexPath.row].option3
        let option1Count = opinion[indexPath.row].option1 + "  :  " + opinion[indexPath.row].count1.stringValue
        let option2Count = opinion[indexPath.row].option2 + "  :  " + opinion[indexPath.row].count2.stringValue
        let option3Count = opinion[indexPath.row].option3 + "  :  " + opinion[indexPath.row].count3.stringValue
        cell.footer.text = option1Count + "\t" + option2Count + "\t" + option3Count
        return cell
    }
}
