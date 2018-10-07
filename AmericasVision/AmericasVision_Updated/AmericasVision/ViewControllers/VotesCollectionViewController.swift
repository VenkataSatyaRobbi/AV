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
    var countdownTimer = Timer()
    var releaseDate: NSDate?
    
    
    let header: UILabel = {
        let label = UILabel()
        label.textColor = UIColor.white
        label.font = UIFont.boldSystemFont(ofSize: 14)
        label.textAlignment = .left
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let headerTimer: UILabel = {
        let label = UILabel()
        label.textColor = UIColor.white
        label.font = UIFont.boldSystemFont(ofSize: 14)
        label.textAlignment = .left
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
     let viewfooter: UIButton = {
        let button = UIButton()
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
        label.textColor = UIColor.darkGray
        label.font = UIFont.systemFont(ofSize: 14)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.sizeToFit()
        label.numberOfLines = 0
        return label
    }()
    
    let optionTwo: UILabel = {
        let label = UILabel()
        label.textColor = UIColor.darkGray
        label.font = UIFont.systemFont(ofSize: 14)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.sizeToFit()
        label.numberOfLines = 0
        return label
    }()
    
    let OptionThree: UILabel = {
        let label = UILabel()
        label.textColor = UIColor.darkGray
        label.font = UIFont.systemFont(ofSize: 14)
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
    
    let option1Radio: AVRadioButton = {
        let radioButton = AVRadioButton()
        radioButton.awakeFromNib()
        radioButton.translatesAutoresizingMaskIntoConstraints = false
        return radioButton
    }()
    
    let option2Radio: AVRadioButton = {
        let radioButton = AVRadioButton()
        radioButton.awakeFromNib()
        radioButton.translatesAutoresizingMaskIntoConstraints = false
        return radioButton
    }()
    
    let option3Radio: AVRadioButton = {
        let radioButton = AVRadioButton()
        radioButton.awakeFromNib()
        radioButton.translatesAutoresizingMaskIntoConstraints = false
        return radioButton
    }()
    
    let likeButton1: UIButton = {
        let likeButton = UIButton()
        likeButton.translatesAutoresizingMaskIntoConstraints = false
        likeButton.setImage(UIImage(named: "like"), for: .normal)
        likeButton.tag = 1
        return likeButton
    }()
    
    let likeButton2: UIButton = {
        let likeButton = UIButton()
        likeButton.translatesAutoresizingMaskIntoConstraints = false
        likeButton.setImage(UIImage(named: "like"), for: .normal)
        likeButton.tag = 2
        return likeButton
    }()
    
    let likeButton3: UIButton = {
        let likeButton = UIButton()
        likeButton.translatesAutoresizingMaskIntoConstraints = false
        likeButton.setImage(UIImage(named: "like"), for: .normal)
        likeButton.tag = 3
        return likeButton
    }()
    
    let chartView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    lazy var pieChart: PieChartView = {
        let p = PieChartView()
        p.translatesAutoresizingMaskIntoConstraints = false
        p.noDataText = "No date to display"
        p.legend.enabled = false
        p.chartDescription?.text = ""
        p.drawHoleEnabled = false
        return p
    }()
    
    override init(frame: CGRect) {
        
        super.init(frame: frame)
        backgroundColor = UIColor.white
        self.headerView.addSubview(header)
        self.headerView.addSubview(headerTimer)
        self.addSubview(headerView)
        self.addSubview(question)
        likeButton1.addSubview(scoreBoard1)
        self.addSubview(likeButton1)
        likeButton2.addSubview(scoreBoard2)
        self.addSubview(likeButton2)
        likeButton3.addSubview(scoreBoard3)
        self.addSubview(likeButton3)
        self.addSubview(option1Radio)
        self.addSubview(optionOne)
        self.addSubview(option2Radio)
        self.addSubview(optionTwo)
        self.addSubview(option3Radio)
        self.addSubview(OptionThree)
        self.addSubview(viewfooter)
        self.addSubview(chartView)
        
        self.layer.shadowColor = UIColor.black.cgColor
        self.layer.shadowOffset = CGSize(width: 0, height: 3.0)
        self.layer.shadowRadius = 3.0
        self.layer.shadowOpacity = 0.5
        self.layer.masksToBounds = false
        self.layer.shadowPath = UIBezierPath(roundedRect: self.bounds, cornerRadius: self.layer.cornerRadius).cgPath
       
    }
    
    func addAllignments(){
        
        headerView.leftAnchor.constraint(equalTo: leftAnchor, constant:0).isActive = true
        headerView.topAnchor.constraint(equalTo: topAnchor, constant:0).isActive = true
        headerView.heightAnchor.constraint(equalToConstant:32).isActive = true
        headerView.widthAnchor.constraint(equalToConstant:self.frame.width).isActive = true
        
        header.leftAnchor.constraint(equalTo: leftAnchor, constant:5).isActive = true
        header.topAnchor.constraint(equalTo: topAnchor, constant:0).isActive = true
        header.heightAnchor.constraint(equalToConstant:35).isActive = true
        
        headerTimer.rightAnchor.constraint(equalTo: rightAnchor, constant:-5).isActive = true
        headerTimer.topAnchor.constraint(equalTo: topAnchor, constant:0).isActive = true
        headerTimer.heightAnchor.constraint(equalToConstant:35).isActive = true
        
        question.leftAnchor.constraint(equalTo: leftAnchor, constant:5).isActive = true
        question.topAnchor.constraint(equalTo: topAnchor, constant:40).isActive = true
        question.heightAnchor.constraint(equalToConstant:questionTextheight).isActive = true
        question.widthAnchor.constraint(equalToConstant: self.frame.width).isActive = true
        
        let top1 = questionTextheight + 40
        let top2 = top1 + option1Height
        let top3 = top2 + option2Height
        
        likeButton1.leftAnchor.constraint(equalTo: leftAnchor, constant: 5).isActive = true
        likeButton1.topAnchor.constraint(equalTo: topAnchor, constant: top1).isActive = true
        likeButton1.widthAnchor.constraint(equalToConstant:32).isActive = true
        
        likeButton2.leftAnchor.constraint(equalTo: leftAnchor, constant: 5).isActive = true
        likeButton2.topAnchor.constraint(equalTo: topAnchor, constant: top2).isActive = true
        likeButton2.widthAnchor.constraint(equalToConstant:32).isActive = true
        
        likeButton3.leftAnchor.constraint(equalTo: leftAnchor, constant: 5).isActive = true
        likeButton3.topAnchor.constraint(equalTo: topAnchor, constant: top3).isActive = true
        likeButton3.widthAnchor.constraint(equalToConstant:32).isActive = true
        
        scoreBoard1.leftAnchor.constraint(equalTo: leftAnchor, constant: 5).isActive = true
        scoreBoard1.topAnchor.constraint(equalTo: topAnchor, constant: top1+22).isActive = true
        scoreBoard1.widthAnchor.constraint(equalToConstant:32).isActive = true
        
        scoreBoard2.leftAnchor.constraint(equalTo: leftAnchor, constant: 5).isActive = true
        scoreBoard2.topAnchor.constraint(equalTo: topAnchor, constant: top2+22).isActive = true
        scoreBoard2.widthAnchor.constraint(equalToConstant:32).isActive = true
        
        scoreBoard3.leftAnchor.constraint(equalTo: leftAnchor, constant: 5).isActive = true
        scoreBoard3.topAnchor.constraint(equalTo: topAnchor, constant: top3+22).isActive = true
        scoreBoard3.widthAnchor.constraint(equalToConstant:32).isActive = true
        
        option1Radio.leftAnchor.constraint(equalTo: leftAnchor, constant: 55).isActive = true
        option1Radio.topAnchor.constraint(equalTo: topAnchor, constant: top1).isActive = true
        
        option2Radio.leftAnchor.constraint(equalTo: leftAnchor, constant: 55).isActive = true
        option2Radio.topAnchor.constraint(equalTo: topAnchor, constant: top2).isActive = true
        
        option3Radio.leftAnchor.constraint(equalTo: leftAnchor, constant: 55).isActive = true
        option3Radio.topAnchor.constraint(equalTo: topAnchor, constant: top3).isActive = true
        
        option1Radio.alternateButton.append(option2Radio)
        option1Radio.alternateButton.append(option3Radio)
        option2Radio.alternateButton.append(option1Radio)
        option2Radio.alternateButton.append(option3Radio)
        option3Radio.alternateButton.append(option1Radio)
        option3Radio.alternateButton.append(option2Radio)
        
        optionOne.leftAnchor.constraint(equalTo: leftAnchor, constant: 100).isActive = true
        optionOne.topAnchor.constraint(equalTo: topAnchor, constant: top1).isActive = true
        optionOne.widthAnchor.constraint(equalToConstant: self.frame.width - 95 ).isActive = true
        optionOne.heightAnchor.constraint(equalToConstant: option1Height)
        
        optionTwo.leftAnchor.constraint(equalTo: leftAnchor, constant: 100).isActive = true
        optionTwo.topAnchor.constraint(equalTo: topAnchor, constant: top2).isActive = true
        optionTwo.widthAnchor.constraint(equalToConstant: self.frame.width - 95 ).isActive = true
        optionTwo.heightAnchor.constraint(equalToConstant: option2Height)
        
        OptionThree.leftAnchor.constraint(equalTo: leftAnchor, constant: 100).isActive = true
        OptionThree.topAnchor.constraint(equalTo: topAnchor, constant: top3).isActive = true
        OptionThree.widthAnchor.constraint(equalToConstant: self.frame.width - 95 ).isActive = true
        OptionThree.heightAnchor.constraint(equalToConstant: option3Height)
   
        viewfooter.leftAnchor.constraint(equalTo: leftAnchor, constant: 15).isActive = true
        viewfooter.topAnchor.constraint(equalTo: topAnchor, constant: top3 + option3Height + 5).isActive = true
        viewfooter.heightAnchor.constraint(equalToConstant:32).isActive = true
        viewfooter.widthAnchor.constraint(equalToConstant: self.frame.width-30).isActive = true
        
        chartView.leftAnchor.constraint(equalTo: leftAnchor, constant:5).isActive = true
        chartView.topAnchor.constraint(equalTo: topAnchor, constant:top3 + option3Height + 47).isActive = true
        chartView.heightAnchor.constraint(equalToConstant:self.frame.height - top3 - option3Height - 47).isActive = true
        chartView.widthAnchor.constraint(equalToConstant: self.frame.width-10).isActive = true
    }
    
   func pieChartSetup(){
        setupPieChart()
        fillChart()
    }
    
    func setupPieChart() {
        pieChart.legend.enabled  = true
        pieChart.drawHoleEnabled = true
        pieChart.chartDescription?.text = "Opinion Dashboard"
        pieChart.chartDescription?.textColor = UIColor(red: 6/255, green: 90/255, blue: 157/255, alpha: 1)
        pieChart.chartDescription?.font = NSUIFont.boldSystemFont(ofSize: 12)
        self.chartView.addSubview(pieChart)
        pieChart.centerXAnchor.constraint(equalTo: chartView.centerXAnchor, constant: 0).isActive = true
        pieChart.centerYAnchor.constraint(equalTo: chartView.centerYAnchor, constant: 0).isActive = true
        pieChart.widthAnchor.constraint(equalTo: chartView.widthAnchor, multiplier: 1).isActive = true
        pieChart.heightAnchor.constraint(equalTo: chartView.heightAnchor, multiplier: 1).isActive = true
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
    
    func startTimer(){
        countdownTimer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(updateTime), userInfo: nil, repeats: true)
    }
    
    @IBAction func updateTime() {
        let currentDate = CommonUtils.getThisMonthEnd()
        let calendar = Calendar.current
        let diffDateComponents = calendar.dateComponents([.day, .hour, .minute, .second], from: Date() as Date,to: currentDate)
        let countdown = "\(diffDateComponents.day ?? 0) : \(diffDateComponents.hour ?? 0) : \(diffDateComponents.minute ?? 0) : \(diffDateComponents.second ?? 0)"
        headerTimer.text = countdown
    }
    
}

class VotesCollectionViewController: UICollectionViewController{
    
    @IBOutlet weak var VotesHomeButton: UIBarButtonItem!
    
    let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
    
    var opinions = [Opinion]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = "Opinion Poll"
        sideMenus()
        self.collectionView?.backgroundColor = UIColor.white
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
        let ref = DBProvider.instance.opinionRef
        ref.queryOrdered(byChild: "Date").observe(.childAdded){(snapshot: DataSnapshot) in
            if let dict = snapshot.value as? [String: Any] {
                let id = snapshot.key as String
                let question = dict["Question"] as! String
                let option1 = dict["Option1"] as! String
                let option2 = dict["Option2"] as! String
                let option3 = dict["Option3"] as! String
                let count1 = dict["Count1"] as! NSNumber
                let count2 = dict["Count2"] as! NSNumber
                let count3 = dict["Count3"] as! NSNumber
                let publishDate = dict["Date"] as! Double
                let opinion = Opinion.init(id:id,question: question, option1: option1, option2: option2, option3: option3, publishDate: publishDate,count1: count1,count2: count2,count3: count3)
                let users = dict["voteusers"] as! [String: Any]
                for user in users{
                    if AVAuthService.getCurrentUserId() == user.key as String {
                        let userDic = user.value as? [String: Any]
                        opinion.selectedOption = userDic?["SelectedOption"] as! String
                        break
                    }
                }
                self.opinions.append(opinion)
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
        return opinions.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let id = opinions[indexPath.row].id
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! VoteCell
        
        cell.header.text = "Question-" + String(indexPath.row+1)
        cell.opinionId = id
        cell.question.text = opinions[indexPath.row].question
        cell.optionOne.text = opinions[indexPath.row].option1
        cell.optionTwo.text = opinions[indexPath.row].option2
        cell.OptionThree.text = opinions[indexPath.row].option3
        
        cell.startTimer()
        cell.releaseDate = CommonUtils.convertTimeFromSeconds(seconds: opinions[indexPath.row].publishDate)
        
        let questionTextheight = CommonUtils.calculateHeight(text:opinions[indexPath.row].question, width: (self.collectionView?.frame.size.width)! - 20)
        let option1Height = CommonUtils.calculateHeight(text:opinions[indexPath.row].option1, width: (self.collectionView?.frame.size.width)! - 95)
        let option2Height = CommonUtils.calculateHeight(text:opinions[indexPath.row].option2, width: (self.collectionView?.frame.size.width)! - 95)
        let option3Height = CommonUtils.calculateHeight(text:opinions[indexPath.row].option3, width: (self.collectionView?.frame.size.width)! - 95)
        cell.questionTextheight = questionTextheight
        
        cell.option1Height = option1Height > 40 ? option1Height : 40
        cell.option2Height = option2Height > 40 ? option2Height : 40
        cell.option3Height = option3Height > 40 ? option3Height : 40
        cell.addAllignments()
        
        if opinions[indexPath.row].selectedOption == opinions[indexPath.row].option1 {
            cell.option1Radio.isSelected = true
        }else if opinions[indexPath.row].selectedOption == opinions[indexPath.row].option2 {
            cell.option2Radio.isSelected = true
        }else if opinions[indexPath.row].selectedOption == opinions[indexPath.row].option3 {
            cell.option3Radio.isSelected = true
        }
        
        if opinions[indexPath.row].selectedOption != "" {
           cell.option1Radio.isEnabled = false
           cell.option2Radio.isEnabled = false
           cell.option3Radio.isEnabled = false
           cell.viewfooter.isEnabled = false
           cell.viewfooter.setTitle("Thanks for your Opinion", for: .normal)
        }
        
        cell.surveyData.updateValue(opinions[indexPath.row].count1, forKey: opinions[indexPath.row].option1)
        cell.surveyData.updateValue(opinions[indexPath.row].count2, forKey: opinions[indexPath.row].option2)
        cell.surveyData.updateValue(opinions[indexPath.row].count3, forKey: opinions[indexPath.row].option3)
        cell.totalCount = opinions[indexPath.row].count1.doubleValue + opinions[indexPath.row].count2.doubleValue + opinions[indexPath.row].count3.doubleValue
        cell.pieChartSetup( )
        
        cell.scoreBoard1.text = opinions[indexPath.row].count1.stringValue
        cell.scoreBoard2.text = opinions[indexPath.row].count2.stringValue
        cell.scoreBoard3.text = opinions[indexPath.row].count3.stringValue
        
        cell.viewfooter.tag = indexPath.item
        cell.viewfooter.addTarget(self,action: #selector(self.handlePollButton(_:)),for: .touchUpInside)
        cell.likeButton1.addTarget(self,action: #selector(self.getVotedUsers(_:)),for: .touchUpInside)
        cell.likeButton2.addTarget(self,action: #selector(self.getVotedUsers(_:)),for: .touchUpInside)
        cell.likeButton3.addTarget(self,action: #selector(self.getVotedUsers(_:)),for: .touchUpInside)
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
    
    @IBAction func getVotedUsers(_ sender: UIButton) {
        let buttonPosition:CGPoint = sender.convert(CGPoint.zero, to:self.collectionView)
        let indexPath = self.collectionView?.indexPathForItem(at: buttonPosition)
        let cell = collectionView?.cellForItem(at: indexPath!) as! VoteCell
        let storyBoard : UIStoryboard = UIStoryboard(name: "AV", bundle:nil)
        let nextViewController = VotedUsersTableViewController()
        nextViewController.opinionId = cell.opinionId
        
        if sender.tag == 1 {
            nextViewController.option = cell.optionOne.text!
            nextViewController.title = "Option 1"
        }else if sender.tag == 2 {
            nextViewController.option = cell.optionTwo.text!
            nextViewController.title = "Option 2"
        }else{
            nextViewController.option = cell.OptionThree.text!
            nextViewController.title = "Option 3"
        }
        self.navigationController?.pushViewController(nextViewController, animated: true)
       
    }
    
}
