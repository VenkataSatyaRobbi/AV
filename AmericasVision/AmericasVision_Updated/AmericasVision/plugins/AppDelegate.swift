//
//  AppDelegate.swift
//  AmericasVision
//
//  Created by Venkata Satya R Robbi on 3/31/18.
//  Copyright © 2018 zeroGravity. All rights reserved.
//

import UIKit
import Firebase
import FBSDKCoreKit
import FBSDKLoginKit
//import FileExplorer

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        
        UITabBar.appearance().tintColor = UIColor(displayP3Red: 70/255, green: 146/255, blue: 250/255, alpha: 1)
        UITabBar.appearance().barTintColor = UIColor.white
        //UINavigationBar.appearance().barTintColor = UIColor(red: 51/255, green: 90/255, blue: 149/255, alpha: 1)
        UINavigationBar.appearance().barTintColor = UIColor(red: 0/255, green: 180/255, blue: 210/255, alpha: 1)
        
       
        UINavigationBar.appearance().tintColor = UIColor.white
        
      //  application.statusBarStyle = .lightContent
        UIApplication.shared.statusBarStyle = UIStatusBarStyle.lightContent
        
        FirebaseApp.configure()
        //FBSDKLoginButton.classForCoder()
        
     
       
        
        
       //uploadMusicAlbum()
        
        
        return FBSDKApplicationDelegate.sharedInstance().application(application, didFinishLaunchingWithOptions: launchOptions)
    }
    
//    func uploadMusicAlbum()
//    {
//        let directoryURL = URL.documentDirectory
//        
//        let audioURL = Bundle.main.url(forResource: "audio", withExtension: "mp3")!
//        let videoURL = Bundle.main.url(forResource: "video", withExtension: "mp4")!
//        let pdfURL = Bundle.main.url(forResource: "pdf", withExtension: "pdf")!
//        let image = UIImage(named: "image.jpg")!
//        let imageData = UIImagePNGRepresentation(image)!
//        
//        
//        let firstDirectoryURL = directoryURL.appendingPathComponent("Directory")
//        try? FileManager.default.createDirectory(at: firstDirectoryURL, withIntermediateDirectories: true, attributes: [FileAttributeKey: Any]())
//        
//        let items = [
//            (audioURL, "audio.mp3"),
//            (videoURL, "video.mp4"),
//            (pdfURL, "pdf.pdf")
//        ]
//        for (url, filename) in items {
//            let destinationURL = firstDirectoryURL.appendingPathComponent(filename)
//            try? FileManager.default.copyItem(at: url, to: destinationURL)
//        }
//        
//        let imageURL = firstDirectoryURL.appendingPathComponent("image.png")
//        try? imageData.write(to: imageURL)
//        
//        let subdirectoryURL = firstDirectoryURL.appendingPathComponent("Empty Directory")
//        try? FileManager.default.createDirectory(at: subdirectoryURL, withIntermediateDirectories: true, attributes: [FileAttributeKey: Any]())
//        
//        let secondDirectoryURL = directoryURL.appendingPathComponent("Empty Directory")
//        try? FileManager.default.createDirectory(at: secondDirectoryURL, withIntermediateDirectories: true, attributes: [FileAttributeKey: Any]())
//        
//        
//        
//    }
    
    private func application(application: UIApplication, openURL url: NSURL, sourceApplication: String?, annotation: AnyObject?) -> Bool{
        return FBSDKApplicationDelegate.sharedInstance().application(application, open: url as URL?, sourceApplication: sourceApplication, annotation: annotation)
    }

    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
        
        FBSDKAppEvents.activateApp()
    }

    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }


}

