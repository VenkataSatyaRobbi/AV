//
//  CommonUtils.swift
//  AmericasVision
//
//  Created by Mohan Dola on 29/07/18.
//  Copyright © 2018 zeroGravity. All rights reserved.
//

import Foundation

class CommonUtils {
    
    static func convertFromTimestamp(seconds: Double) -> String {
        let time = seconds/1000.0
        let dateFormatter =  DateFormatter()
        dateFormatter.dateFormat = "MM-dd-yyyy"
        let date = Date(timeIntervalSince1970: TimeInterval(time))
        return dateFormatter.string(from: date)
    }

}
