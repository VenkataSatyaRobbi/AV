//
//  CommonUtils.swift
//  AmericasVision
//
//  Created by Mohan Dola on 29/07/18.
//  Copyright © 2018 zeroGravity. All rights reserved.
//

import Foundation

enum LINE_POSITION {
    case LINE_POSITION_TOP
    case LINE_POSITION_BOTTOM
}

class CommonUtils {
    
    static func convertFromTimestamp(seconds: Double) -> String {
        let time = seconds
        let dateFormatter =  DateFormatter()
        dateFormatter.dateFormat = "MM-dd-yyyy"
        let date = Date(timeIntervalSince1970: TimeInterval(time))
        return dateFormatter.string(from: date)
    }
    
    static func convertTimeFromSeconds(seconds: Double) -> NSDate {
        let dateFormatter =  DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        return NSDate(timeIntervalSince1970: TimeInterval(seconds))
    }
    
    static func convertStringFromDate(date:Date) -> String {
        let dateFormatter =  DateFormatter()
        dateFormatter.dateFormat = "MMM d, h:mm a"
        return dateFormatter.string(from: date)
    }
    
    static func calculateHeight(text:String, width: CGFloat)  -> CGFloat {
        
        let attributes: [NSAttributedStringKey : Any] = [NSAttributedStringKey.font : UIFont.systemFont(ofSize: 15.0)]
        //Add AvalinNext Regular
        let approximateWidth = width
        let size = CGSize(width: approximateWidth, height:10000)
        let estimatedSize = NSString(string: text).boundingRect(with: size, options: .usesLineFragmentOrigin, attributes: attributes, context: nil)
        let height = estimatedSize.height
        return height
    }
    
   static func addLineToView(view : UIView, position : LINE_POSITION, color: UIColor, width: Double) {
        let lineView = UIView()
        lineView.backgroundColor = color
        lineView.translatesAutoresizingMaskIntoConstraints = false // This is important!
        view.addSubview(lineView)
        
        let metrics = ["width" : NSNumber(value: width)]
        let views = ["lineView" : lineView]
        view.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|[lineView]|", options:NSLayoutFormatOptions(rawValue: 0), metrics:metrics, views:views))
        
        switch position {
        case .LINE_POSITION_TOP:
            view.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|[lineView(width)]", options:NSLayoutFormatOptions(rawValue: 0), metrics:metrics, views:views))
            break
        case .LINE_POSITION_BOTTOM:
            view.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:[lineView(width)]|", options:NSLayoutFormatOptions(rawValue: 0), metrics:metrics, views:views))
            break
        default:
            break
        }
    }
    
    static func reachabilityAlert(){
//        if Reachability.isConnectedToNetwork() == true {
//            println("Internet connection OK")
//        } else {
//            println("Internet connection FAILED")
//            var alert = UIAlertView(title: "No Internet Connection", message: "Make sure your device is connected to the internet.", delegate: nil, cancelButtonTitle: "OK")
//            alert.show()
//        }
    }

}
