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
    
    let opinionButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = UIColor.red
        button.setTitle("Save", for: .normal)
        button.addTarget(self, action:"buttonAction", for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
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
    
    let option1Radio: RadioButton = {
        let radioButton = RadioButton()
        radioButton.awakeFromNib()
        radioButton.translatesAutoresizingMaskIntoConstraints = false
       return radioButton
    }()
    
    let option2Radio: RadioButton = {
        let radioButton = RadioButton()
        radioButton.awakeFromNib()
        radioButton.translatesAutoresizingMaskIntoConstraints = false
        return radioButton
    }()
    
    let option3Radio: RadioButton = {
        let radioButton = RadioButton()
        radioButton.awakeFromNib()
        radioButton.translatesAutoresizingMaskIntoConstraints = false
        return radioButton
    }()

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
    
    let surveyData = ["Any":1]
   
    override init(frame: CGRect) {
        
        super.init(frame: frame)
        backgroundColor = UIColor.white
        headerView.addSubview(header)
        headerView.addSubview(opinionButton)
        self.addSubview(headerView)
        self.addSubview(question)
        self.addSubview(option1Radio)
        self.addSubview(optionOne)
        self.addSubview(option2Radio)
        self.addSubview(optionTwo)
        self.addSubview(option3Radio)
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
        
        opinionButton.topAnchor.constraint(equalTo: topAnchor, constant:0).isActive = true
        opinionButton.rightAnchor.constraint(equalTo: rightAnchor, constant:-15).isActive = true
        opinionButton.heightAnchor.constraint(equalToConstant:32).isActive = true
        
        question.leftAnchor.constraint(equalTo: leftAnchor, constant: 5).isActive = true
        question.topAnchor.constraint(equalTo: topAnchor, constant: 0).isActive = true
        question.heightAnchor.constraint(equalToConstant:94).isActive = true
        question.widthAnchor.constraint(equalToConstant: self.frame.width).isActive = true
        question.sizeToFit()
        question.numberOfLines = 0
        
        
        option1Radio.leftAnchor.constraint(equalTo: leftAnchor, constant: 5).isActive = true
        option1Radio.topAnchor.constraint(equalTo: topAnchor, constant: 60).isActive = true
        option1Radio.widthAnchor.constraint(equalToConstant: 20).isActive = true
        option1Radio.heightAnchor.constraint(equalToConstant: 20).isActive = true
        
        option2Radio.leftAnchor.constraint(equalTo: leftAnchor, constant: 5).isActive = true
        option2Radio.topAnchor.constraint(equalTo: topAnchor, constant: 90).isActive = true
        option2Radio.widthAnchor.constraint(equalToConstant: 20).isActive = true
        option2Radio.heightAnchor.constraint(equalToConstant: 20).isActive = true
        
        option3Radio.leftAnchor.constraint(equalTo: leftAnchor, constant: 5).isActive = true
        option3Radio.topAnchor.constraint(equalTo: topAnchor, constant: 120).isActive = true
        option3Radio.widthAnchor.constraint(equalToConstant: 20).isActive = true
        option3Radio.heightAnchor.constraint(equalToConstant: 20).isActive = true
        
        option1Radio.alternateButton?.append(option2Radio)
        option1Radio.alternateButton?.append(option3Radio)
        option2Radio.alternateButton?.append(option1Radio)
        option2Radio.alternateButton?.append(option3Radio)
        option3Radio.alternateButton?.append(option1Radio)
        option3Radio.alternateButton?.append(option2Radio)
        
        optionOne.leftAnchor.constraint(equalTo: leftAnchor, constant: 55).isActive = true
        optionOne.topAnchor.constraint(equalTo: topAnchor, constant: 60).isActive = true
        optionOne.heightAnchor.constraint(equalToConstant:30).isActive = true
        optionOne.widthAnchor.constraint(equalToConstant: self.frame.width).isActive = true
        
        optionTwo.leftAnchor.constraint(equalTo: leftAnchor, constant: 55).isActive = true
        optionTwo.topAnchor.constraint(equalTo: topAnchor, constant: 90).isActive = true
        optionTwo.heightAnchor.constraint(equalToConstant:30).isActive = true
        optionTwo.widthAnchor.constraint(equalToConstant: self.frame.width).isActive = true
        
        OptionThree.leftAnchor.constraint(equalTo: leftAnchor, constant: 55).isActive = true
        OptionThree.topAnchor.constraint(equalTo: topAnchor, constant: 120).isActive = true
        OptionThree.heightAnchor.constraint(equalToConstant:30).isActive = true
        OptionThree.widthAnchor.constraint(equalToConstant: self.frame.width).isActive = true
        
        viewfooter.leftAnchor.constraint(equalTo: leftAnchor, constant: 0).isActive = true
        viewfooter.topAnchor.constraint(equalTo: topAnchor, constant: 224).isActive = true
        viewfooter.heightAnchor.constraint(equalToConstant:32).isActive = true
        viewfooter.widthAnchor.constraint(equalToConstant: self.frame.width).isActive = true
        footer.leftAnchor.constraint(equalTo: leftAnchor, constant: 0).isActive = true
        footer.topAnchor.constraint(equalTo: topAnchor, constant: 224).isActive = true
        footer.heightAnchor.constraint(equalToConstant:32).isActive = true
        footer.widthAnchor.constraint(equalToConstant:self.frame.width).isActive = true
     
    }
    
    func buttonAction(sender: UIButton!) {
        let selectedOption = "Option1"
        let userId = AVAuthService.getCurrentUserId()
        let userOpinionRef = DBProvider.instance.opinionRef
        let userRef =  userOpinionRef.child("users").child(userOpinionRef.childByAutoId().key)
        userRef.setValue(["SelectedOption": selectedOption, "userId": userId ], withCompletionBlock:{(error, ref) in
            if error != nil{
                ProgressHUD.showError(error!.localizedDescription)
                return
            }
            self.option1Radio.isEnabled = false
            self.option2Radio.isEnabled = false
            self.option3Radio.isEnabled = false
        })
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
        let chartDataSet = PieChartDataSet(values: dataEntries, label: "opp")
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
        option1Radio.isSelected = true
        option2Radio.isSelected = false
        option3Radio.isSelected = false
    }
    
}

class VotesCollectionViewController: UICollectionViewController{
    
    @IBOutlet weak var VotesHomeButton: UIBarButtonItem!
    
    let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
    
    var opinion = [Opinion]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.collectionView?.backgroundColor = UIColor.groupTableViewBackground
      
        layout.sectionInset = UIEdgeInsets(top: 10, left: 5, bottom: 5, right: 5)
        let cellwidth = Int(self.view.frame.width - 20)
        let cellHeight = Int(self.view.frame.height-30)
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
