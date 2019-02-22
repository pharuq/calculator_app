//
//  WebViewViewController.swift
//  CalculatorApp
//
//  Created by RyomaShindo on 2018/12/18.
//  Copyright © 2018 RyomaShindo. All rights reserved.
//

import UIKit
import Repro
import WebKit

class WebViewViewController: UIViewController, WKUIDelegate {

    var webView: WKWebView!
    
    override func loadView() {
        let webConfiguration = WKWebViewConfiguration()
        webView = WKWebView(frame: .zero, configuration: webConfiguration)
        Repro.startWebViewTracking(webView)
        webView.uiDelegate = self
        view = webView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let myURL = URL(string: "https://pharuq.github.io/web-onbording/")
        let myRequest = URLRequest(url: myURL!)
        webView.load(myRequest)
    }
}
