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
   
    var opinionId:String = ""
    var surveyData = [String:NSNumber]()
    var totalCount:Double = 0
    var questionTextheight:CGFloat = 0
    var option1Height:CGFloat = 0
    var option2Height:CGFloat = 0
    var option3Height:CGFloat = 0
    
    
    let header: UILabel = {
        let label = UILabel()
        label.textColor = UIColor.white
        label.font = UIFont.boldSystemFont(ofSize: 14)
        label.text = "Opinion"
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
     let viewfooter: UIButton = {
        let button = UIButton(type: UIButtonType.system)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.backgroundColor = UIColor(red: 6/255, green: 90/255, blue: 157/255, alpha: 1)
        button.layer.cornerRadius = 4.0
        button.setTitleColor(UIColor.white, for: .normal)
        button.setTitle("Save", for: .normal)
        return button
    }()
    
    let headerView: UIView = {
        let headerView = UIView()
        headerView.backgroundColor = UIColor(red: 6/255, green: 90/255, blue: 157/255, alpha: 1)
        headerView.translatesAutoresizingMaskIntoConstraints = false
        return headerView
    }()
   
    let question: UILabel = {
        let label = UILabel()
        label.textColor = UIColor.black
        label.font = UIFont.boldSystemFont(ofSize: 14)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.sizeToFit()
        label.numberOfLines = 0
        return label
    }()
    
    let optionOne: UILabel = {
        let label = UILabel()
        label.textColor = UIColor.black
        label.font = UIFont.boldSystemFont(ofSize: 14)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.sizeToFit()
        label.numberOfLines = 0
        return label
    }()
    
    let optionTwo: UILabel = {
        let label = UILabel()
        label.textColor = UIColor.black
        label.font = UIFont.boldSystemFont(ofSize: 14)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.sizeToFit()
        label.numberOfLines = 0
        return label
    }()
    
    let OptionThree: UILabel = {
        let label = UILabel()
        label.textColor = UIColor.black
        label.font = UIFont.boldSystemFont(ofSize: 14)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.sizeToFit()
        label.numberOfLines = 0
        return label
    }()
    
    let scoreBoard1 :UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.font = UIFont.boldSystemFont(ofSize: 12)
        label.textColor = .black
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let scoreBoard2 :UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.font = UIFont.boldSystemFont(ofSize: 12)
        label.textColor = .black
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let scoreBoard3 :UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.font = UIFont.boldSystemFont(ofSize: 12)
        label.textColor = .black
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
    
    let imageView1: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.image = UIImage(named: "like")
        return imageView
    }()
    
    let imageView2: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.image = UIImage(named: "like")
        return imageView
    }()
    
    let imageView3: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.image = UIImage(named: "like")
        return imageView
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
    
    override init(frame: CGRect) {
        
        super.init(frame: frame)
        backgroundColor = UIColor.white
        self.headerView.addSubview(header)
        self.addSubview(headerView)
        self.addSubview(question)
        self.addSubview(option1Radio)
        self.addSubview(optionOne)
        self.addSubview(option2Radio)
        self.addSubview(optionTwo)
        self.addSubview(option3Radio)
        self.addSubview(OptionThree)
       
        imageView1.addSubview(scoreBoard1)
        self.addSubview(imageView1)
        imageView2.addSubview(scoreBoard2)
        self.addSubview(imageView2)
        imageView3.addSubview(scoreBoard3)
        self.addSubview(imageView3)
        self.addSubview(viewfooter)
     
    }
    
    func addAllignments(){
        
        headerView.leftAnchor.constraint(equalTo: leftAnchor, constant:0).isActive = true
        headerView.topAnchor.constraint(equalTo: topAnchor, constant:0).isActive = true
        headerView.heightAnchor.constraint(equalToConstant:32).isActive = true
        headerView.widthAnchor.constraint(equalToConstant:self.frame.width).isActive = true
        
        header.leftAnchor.constraint(equalTo: leftAnchor, constant:5).isActive = true
        header.topAnchor.constraint(equalTo: topAnchor, constant:0).isActive = true
        header.heightAnchor.constraint(equalToConstant:35).isActive = true
        header.widthAnchor.constraint(equalToConstant: self.frame.width).isActive = true
        
        question.leftAnchor.constraint(equalTo: leftAnchor, constant:5).isActive = true
        question.topAnchor.constraint(equalTo: topAnchor, constant:40).isActive = true
        question.heightAnchor.constraint(equalToConstant:questionTextheight).isActive = true
        question.widthAnchor.constraint(equalToConstant: self.frame.width).isActive = true
        
        let top1 = questionTextheight + 40
        option1Radio.leftAnchor.constraint(equalTo: leftAnchor, constant: 55).isActive = true
        option1Radio.topAnchor.constraint(equalTo: topAnchor, constant: top1).isActive = true
        
        let top2 = top1 + option1Height
        option2Radio.leftAnchor.constraint(equalTo: leftAnchor, constant: 55).isActive = true
        option2Radio.topAnchor.constraint(equalTo: topAnchor, constant: top2).isActive = true
        
        let top3 = top2 + option2Height
        option3Radio.leftAnchor.constraint(equalTo: leftAnchor, constant: 55).isActive = true
        option3Radio.topAnchor.constraint(equalTo: topAnchor, constant: top3).isActive = true
        
        option1Radio.alternateButton?.append(option2Radio)
        option1Radio.alternateButton?.append(option3Radio)
        option2Radio.alternateButton?.append(option1Radio)
        option2Radio.alternateButton?.append(option3Radio)
        option3Radio.alternateButton?.append(option1Radio)
        option3Radio.alternateButton?.append(option2Radio)
        
        optionOne.leftAnchor.constraint(equalTo: leftAnchor, constant: 110).isActive = true
        optionOne.topAnchor.constraint(equalTo: topAnchor, constant: top1).isActive = true
        optionOne.widthAnchor.constraint(equalToConstant: self.frame.width - 95 ).isActive = true
        optionOne.heightAnchor.constraint(equalToConstant: option1Height)
        
        optionTwo.leftAnchor.constraint(equalTo: leftAnchor, constant: 110).isActive = true
        optionTwo.topAnchor.constraint(equalTo: topAnchor, constant: top2).isActive = true
        optionTwo.widthAnchor.constraint(equalToConstant: self.frame.width - 95 ).isActive = true
        optionTwo.heightAnchor.constraint(equalToConstant: option2Height)
        
        OptionThree.leftAnchor.constraint(equalTo: leftAnchor, constant: 110).isActive = true
        OptionThree.topAnchor.constraint(equalTo: topAnchor, constant: top3).isActive = true
        OptionThree.widthAnchor.constraint(equalToConstant: self.frame.width - 95 ).isActive = true
        OptionThree.heightAnchor.constraint(equalToConstant: option3Height)
   
        imageView1.leftAnchor.constraint(equalTo: leftAnchor, constant: 5).isActive = true
        imageView1.topAnchor.constraint(equalTo: topAnchor, constant: top1).isActive = true
        imageView1.widthAnchor.constraint(equalToConstant:32).isActive = true
        
        imageView2.leftAnchor.constraint(equalTo: leftAnchor, constant: 5).isActive = true
        imageView2.topAnchor.constraint(equalTo: topAnchor, constant: top2).isActive = true
        imageView2.widthAnchor.constraint(equalToConstant:32).isActive = true
        
        imageView3.leftAnchor.constraint(equalTo: leftAnchor, constant: 5).isActive = true
        imageView3.topAnchor.constraint(equalTo: topAnchor, constant: top3).isActive = true
        imageView3.widthAnchor.constraint(equalToConstant:32).isActive = true
        
        scoreBoard1.leftAnchor.constraint(equalTo: leftAnchor, constant: 5).isActive = true
        scoreBoard1.topAnchor.constraint(equalTo: topAnchor, constant: top1).isActive = true
        scoreBoard1.widthAnchor.constraint(equalToConstant:32).isActive = true
        
        scoreBoard2.leftAnchor.constraint(equalTo: leftAnchor, constant: 5).isActive = true
        scoreBoard2.topAnchor.constraint(equalTo: topAnchor, constant: top2).isActive = true
        scoreBoard2.widthAnchor.constraint(equalToConstant:32).isActive = true
        
        scoreBoard3.leftAnchor.constraint(equalTo: leftAnchor, constant: 5).isActive = true
        scoreBoard3.topAnchor.constraint(equalTo: topAnchor, constant: top3).isActive = true
        scoreBoard3.widthAnchor.constraint(equalToConstant:24).isActive = true
        
        viewfooter.leftAnchor.constraint(equalTo: leftAnchor, constant: 15).isActive = true
        viewfooter.topAnchor.constraint(equalTo: topAnchor, constant: top3 + option3Height + 15).isActive = true
        viewfooter.heightAnchor.constraint(equalToConstant:32).isActive = true
        viewfooter.widthAnchor.constraint(equalToConstant: self.frame.width-30).isActive = true
        pieChart.setExtraOffsets (left: -5.0, top: top3 + option3Height + 47, right:-5.0, bottom: 0.0)
    }
    
   func pieChartSetup(){
        setupPieChart()
        fillChart()
    }
    
    func setupPieChart() {
       
        pieChart.legend.enabled  = true
        pieChart.drawHoleEnabled = true
        pieChart.chartDescription?.text = "AV Users Opinion Dashboard"
        pieChart.chartDescription?.textColor = UIColor(red: 6/255, green: 90/255, blue: 157/255, alpha: 1)
        pieChart.chartDescription?.font = NSUIFont.boldSystemFont(ofSize: 12)
        addSubview(pieChart)
        pieChart.centerXAnchor.constraint(equalTo: centerXAnchor, constant: 0).isActive = true
        pieChart.centerYAnchor.constraint(equalTo: centerYAnchor, constant: 0).isActive = true
        pieChart.widthAnchor.constraint(equalTo: widthAnchor, multiplier: 1).isActive = true
        pieChart.heightAnchor.constraint(equalTo: heightAnchor, multiplier: 1).isActive = true
    }
    
    func fillChart() {
        var dataEntries = [PieChartDataEntry]()
        for (key, val) in surveyData {
            let percent = Double(val.doubleValue * 100 / totalCount)
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
    }
    
}

class VotesCollectionViewController: UICollectionViewController{
    
    @IBOutlet weak var VotesHomeButton: UIBarButtonItem!
    
    let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
    
    var opinion = [Opinion]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = "Opinion Poll"
       // sideMenus()
        self.collectionView?.backgroundColor = UIColor.groupTableViewBackground
            //UIColor(red: 100/255, green:100/255, blue: 100/255, alpha: 1)
        
        layout.sectionInset = UIEdgeInsets(top: 10, left: 5, bottom: 5, right: 5)
        let cellwidth = Int(self.view.frame.width - 10)
        let cellHeight = Int(self.view.frame.height-((self.navigationController?.navigationBar.frame.height)!+25))
        layout.itemSize = CGSize(width: cellwidth, height: cellHeight)
        
        fetchFirstOpinion()
        
        self.collectionView?.collectionViewLayout = layout
        //  Register cell classes
        collectionView!.register(VoteCell.self, forCellWithReuseIdentifier: "cell")
        collectionView?.dataSource = self
        collectionView?.delegate = self
        
    }
    
    func fetchFirstOpinion(){
        DBProvider.instance.opinionRef.queryOrdered(byChild: "Date").queryLimited(toFirst: 1).observe(.childAdded)
            //queryOrdered(byChild: "Date").observe(.childAdded)
        { (snapshot: DataSnapshot) in
            if let dict = snapshot.value as? [String: Any] {
                let id = snapshot.key as String
                let question = dict["Question"] as! String
                let option1 = dict["Option1"] as! String
                let option2 = dict["Option2"] as! String
                let option3 = dict["Option3"] as! String
                let count1 = dict["Count1"] as! NSNumber
                let count2 = dict["Count2"] as! NSNumber
                let count3 = dict["Count3"] as! NSNumber
                //let publishDate = dict["Date"] as! Date
                let data = Opinion.init(id:id,question: question, option1: option1, option2: option2, option3: option3, publishDate: Date(),count1: count1,count2: count2,count3: count3)
                self.opinion.append(data)
                self.collectionView?.reloadData()
            }
            
        }
    }
    
    func isUserVoted(id:String,index:Int){
        DBProvider.instance.opinionRef.child(id).child("voteusers").child(AVAuthService.getCurrentUserId())
            .observe(DataEventType.value){(snapshot:DataSnapshot) in
            if let data = snapshot.value as? String {
                    self.opinion[index].selectedOption = data
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
        let id = opinion[indexPath.row].id
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! VoteCell
        cell.opinionId = id
        cell.question.text = opinion[indexPath.row].question
        cell.optionOne.text = opinion[indexPath.row].option1
        cell.optionTwo.text = opinion[indexPath.row].option2
        cell.OptionThree.text = opinion[indexPath.row].option3
        
        let questionTextheight = CommonUtils.calculateHeight(text:opinion[indexPath.row].question, width: (self.collectionView?.frame.size.width)! - 20)
        let option1Height = CommonUtils.calculateHeight(text:opinion[indexPath.row].option1, width: (self.collectionView?.frame.size.width)! - 95)
        let option2Height = CommonUtils.calculateHeight(text:opinion[indexPath.row].option2, width: (self.collectionView?.frame.size.width)! - 95)
        let option3Height = CommonUtils.calculateHeight(text:opinion[indexPath.row].option3, width: (self.collectionView?.frame.size.width)! - 95)
        cell.questionTextheight = questionTextheight
        
        cell.option1Height = option1Height
        cell.option2Height = option2Height
        cell.option3Height = option3Height
        cell.addAllignments()
        
        isUserVoted(id: id,index: indexPath.row)
        
        if opinion[indexPath.row].selectedOption == opinion[indexPath.row].option1 {
            cell.option1Radio.isSelected = true
        }else if opinion[indexPath.row].selectedOption == opinion[indexPath.row].option2 {
            cell.option2Radio.isSelected = true
        }else if opinion[indexPath.row].selectedOption == opinion[indexPath.row].option3 {
            cell.option3Radio.isSelected = true
        }
        
        if opinion[indexPath.row].selectedOption != "" {
           cell.option1Radio.isEnabled = false
           cell.option2Radio.isEnabled = false
           cell.option3Radio.isEnabled = false
           cell.viewfooter.isEnabled = false
        }
        
        cell.surveyData.updateValue(opinion[indexPath.row].count1, forKey: opinion[indexPath.row].option1)
        cell.surveyData.updateValue(opinion[indexPath.row].count2, forKey: opinion[indexPath.row].option2)
        cell.surveyData.updateValue(opinion[indexPath.row].count3, forKey: opinion[indexPath.row].option3)
        cell.totalCount = opinion[indexPath.row].count1.doubleValue + opinion[indexPath.row].count2.doubleValue + opinion[indexPath.row].count3.doubleValue
        cell.pieChartSetup( )
        
        cell.scoreBoard1.text = opinion[indexPath.row].count1.stringValue
        cell.scoreBoard2.text = opinion[indexPath.row].count2.stringValue
        cell.scoreBoard3.text = opinion[indexPath.row].count3.stringValue
        
        cell.viewfooter.tag = indexPath.item
        cell.viewfooter.addTarget(self,action: #selector(self.handlePollButton(_:)),for: .touchUpInside)
        return cell
    }
    
    @IBAction func handlePollButton(_ sender: UIButton) {
        let indexPath = IndexPath.init(item: sender.tag, section: 0)
        let cell = collectionView?.cellForItem(at: indexPath) as! VoteCell
        var selectedOption = ""
        if cell.option1Radio.isSelected {
            selectedOption = cell.optionOne.text!
            cell.option1Radio.unselectAlternateButtons()
        }else if cell.option2Radio.isSelected {
            selectedOption = cell.optionTwo.text!
            cell.option2Radio.unselectAlternateButtons()
        }else{
            selectedOption = cell.OptionThree.text!
            cell.option3Radio.unselectAlternateButtons()
        }
        
        let userId = AVAuthService.getCurrentUserId()
        let userOpinionRef = DBProvider.instance.opinionRef
        let userRef =  userOpinionRef.child(cell.opinionId).child("voteusers").child(userId)
        userRef.setValue(["SelectedOption": selectedOption], withCompletionBlock:{(error, ref) in
            if error != nil{
                ProgressHUD.showError(error!.localizedDescription)
                return
            }
            cell.option1Radio.isEnabled = false
            cell.option2Radio.isEnabled = false
            cell.option3Radio.isEnabled = false
        })
        collectionView?.reloadData()
    }
    
}
