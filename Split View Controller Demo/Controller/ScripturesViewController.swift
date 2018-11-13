//
//  ScripturesViewController.swift
//  Split View Controller Demo
//
//  Created by Kyle Gill on 11/8/18.
//  Copyright © 2018 IS 543. All rights reserved.
//

import UIKit
import WebKit

class ScripturesViewController : UIViewController {
    
    var bookId = 101
    var chapter = 2
    
    @IBOutlet weak var webView: WKWebView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let (html, geoplaces) = ScriptureRenderer.sharedRenderer.htmlForBookId(101, chapter: 2)
        webView.loadHTMLString(html, baseURL: nil)
        print(geoplaces)
    }
    
}
