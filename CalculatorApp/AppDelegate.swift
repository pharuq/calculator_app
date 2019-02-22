//
//  AppDelegate.swift
//  CalculatorApp
//
//  Created by RyomaShindo on 2018/07/16.
//  Copyright © 2018年 RyomaShindo. All rights reserved.
//

import UIKit
import Repro
import UserNotifications

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
//        Production
        Repro.setup("3eb4a023-4de6-4f04-95b6-819cf15677f2")
//        development
//        Repro.setup("9c943b66-f359-4a1e-a600-3fd8bded245e")
//         Staging
//        Repro.setup("01986420-b933-4722-9aef-1ee750ca7e72")
        Repro.setLogLevel(RPRLogLevel.debug)
        
        print("IDFV")
        print(Repro.getDeviceID())
        print("Current userID")
        print(Repro.getUserID())
//        Repro.setUserID(Repro.getDeviceID())
        Repro.setUserID("20181213")
        
        Repro.startRecording()
        
//        if #available (iOS 10.0, *) {
//            let center = UNUserNotificationCenter.current()
//            UNUserNotificationCenter.current().delegate = self as? UNUserNotificationCenterDelegate
//            center.requestAuthorization(options: [.sound, .alert, .badge], completionHandler: { (granted, error) in
//            })
//            application.registerForRemoteNotifications()
//        } else {
//            let settings: UIUserNotificationSettings = UIUserNotificationSettings(types: [.alert, .badge, .sound], categories: nil)
//            UIApplication.shared.registerUserNotificationSettings(settings)
//            UIApplication.shared.registerForRemoteNotifications()
//        }
        Repro.track("Launching event", properties:nil)
        Repro.track("Launching event2", properties:nil)

        return true
    }
    
    func application(_ application: UIApplication, didReceiveRemoteNotification userInfo: [AnyHashable : Any], fetchCompletionHandler completionHandler: @escaping (UIBackgroundFetchResult) -> Void) {
        // userInfo の処理
        application.applicationIconBadgeNumber = 3;
    }
//    func application(application: UIApplication, didReceiveRemoteNotification userInfo: [NSObject : AnyObject]) {
//        // userInfo の処理
//        application.applicationIconBadgeNumber = 3;
//    }
    
    func application(_ app: UIApplication, open url: URL, options: [UIApplicationOpenURLOptionsKey : Any] = [:]) -> Bool {
        print("url : \(url.absoluteString)")
        print("scheme : \(url.scheme!)")
        print("host : \(url.host!)")
//        print("port : \(url.port!)")
//        print("query : \(url.query!)")
        
        UIApplication.shared.open(URL(string: "https://itunes.apple.com/jp/app/id985100673?t=1550207480477")!, options: [:], completionHandler: nil)

        //リクエストされたURLの中からhostの値を取得して変数に代入
        let urlHost : String = (url.host as String?)!
        
        //遷移させたいViewControllerが格納されているStoryBoardファイルを指定
        let mainStoryboard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        
        //urlHostにnextが入っていた場合はmainstoryboard内のnextViewControllerのviewを表示する
        if(urlHost == "next"){
            if #available (iOS 10.0, *) {
                let center = UNUserNotificationCenter.current()
                UNUserNotificationCenter.current().delegate = self as? UNUserNotificationCenterDelegate
                center.requestAuthorization(options: [.sound, .alert, .badge], completionHandler: { (granted, error) in
                })
                app.registerForRemoteNotifications()
            } else {
                let settings: UIUserNotificationSettings = UIUserNotificationSettings(types: [.alert, .badge, .sound], categories: nil)
                UIApplication.shared.registerUserNotificationSettings(settings)
                UIApplication.shared.registerForRemoteNotifications()
            }
            
            let resultVC: next2ViewController = mainStoryboard.instantiateViewController(withIdentifier: "next2ViewController") as! next2ViewController
            self.window?.rootViewController = resultVC
        }
        self.window?.makeKeyAndVisible()
        
        return true
    }

    func application(_ application: UIApplication, didRegisterForRemoteNotificationsWithDeviceToken deviceToken: Data) {
        print("deviceToken = \(String(format: "%@", deviceToken as CVarArg) as String)")
        Repro.setPushDeviceToken(deviceToken)
    }
    
    func application(_ application: UIApplication, didFailToRegisterForRemoteNotificationsWithError error: Error) {
        print("Remote Notification Error: \(error)")
    }
    
    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
        print("バックグラウンドに入る。")
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
        application.applicationIconBadgeNumber = 0
    }

    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }


}

