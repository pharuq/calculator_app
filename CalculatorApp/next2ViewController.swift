//
//  next2ViewController.swift
//  CalculatorApp
//
//  Created by RyomaShindo on 2018/07/31.
//  Copyright © 2018年 RyomaShindo. All rights reserved.
//

import UIKit
import Repro

class next2ViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("start viewDidload")
        
        Repro.track("【iOS】viewDidLoad event", properties: nil)
        Repro.setStringUserProfile("setting TEST!!!!!!!!!!", forKey:"strSetting-iOS2")
        Repro.setStringUserProfile("setting A", forKey:"strSetting A")
        Repro.setStringUserProfile("", forKey:"strSetting B")
//        Repro.setStringUserProfile(null, forKey:"strSetting C")
    }

    @IBAction func goWebView(_ sender: UIButton) {
        let next = storyboard!.instantiateViewController(withIdentifier: "WebViewViewController")
        self.present(next,animated: true, completion: nil)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        print("start viewWillApper")
        
        Repro.track("【iOS】viewWillApper event", properties: nil)
//        Repro.pauseRecording()

    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        print("start viewDidApper")
        
        Repro.track("【iOS】viewDidApper event", properties: [
            "rating": 3,
            "string_property": "aaa",
            "string_property_empty": ""
            ])
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        print("start viewWillDisapper")
        
        Repro.track("【iOS】viewWillDisapper event", properties: nil)
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        print("start viewDidDisapper")
        
        Repro.track("【iOS】viewDidDisapper event", properties: nil)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
