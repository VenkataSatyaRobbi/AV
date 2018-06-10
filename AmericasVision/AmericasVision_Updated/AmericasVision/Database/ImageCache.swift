//
//  ImageCache.swift
//  AmericasVision
//
//  Created by Mohan Dola on 30/05/18.
//  Copyright © 2018 zeroGravity. All rights reserved.
//

import Foundation
let imageCache = NSCache<AnyObject, AnyObject>()

extension UIImageView {
    
    func loadImageUsingCache(urlStr:String){
        let url = URL(string: urlStr)
            URLSession.shared.dataTask(with: url!, completionHandler: { (data, response, error) in
                if error != nil {
                    print(error?.localizedDescription as Any)
                    return
                }
                
                DispatchQueue.main.async {
                    if let downloadImageStr = UIImage(data: data!) {
                        imageCache.setObject(downloadImageStr, forKey: urlStr as AnyObject)
                        self.image = downloadImageStr
                    }
                    
                }
            }).resume()
       }
    
}
