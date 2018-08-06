//
//  Opinion.swift
//  AmericasVision
//
//  Created by Mohan Dola on 01/08/18.
//  Copyright © 2018 zeroGravity. All rights reserved.
//

import Foundation

class Opinion{
    
    var question: String
    var option1: String
    var option2: String
    var option3: String
    var publishDate:Date
    var count1:NSNumber
    var count2:NSNumber
    var count3:NSNumber
    
    init(question: String, option1: String, option2: String, option3: String, publishDate: Date,count1:NSNumber,count2:NSNumber,count3:NSNumber){
        self.question = question
        self.option1 = option1
        self.option2 = option2
        self.option3 = option3
        self.publishDate = publishDate
        self.count1 = count1
        self.count2 = count2
        self.count3 = count3
    }
    
}
