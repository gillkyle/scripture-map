//
//  ScripturesViewController.swift
//  Split View Controller Demo
//
//  Created by Kyle Gill on 11/8/18.
//  Copyright © 2018 IS 543. All rights reserved.
//

import UIKit
import WebKit

class ScripturesViewController : UIViewController, WKNavigationDelegate {
    // MARK - Constants
//    let mapButton : UIBarButtonItem = UIBarButtonItem(title: "Show Map", style: UIBarButtonItem.Style.plain, target: self, action: "")
    
    // MARK - Properties
    var bookId = 101
    var chapter = 1
    
    // MARK - Private Properties
    private weak var mapViewController: MapViewController?
    
    // MARK - Outlets
    @IBOutlet weak var webView: WKWebView!
    @IBOutlet weak var mapButton: UIBarButtonItem!
    
    // MARK - View Controller Lifecycle
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        if (MapConfiguration.sharedConfig.hasMapButton) {
            mapButton.title = "Show Map"
        } else {
            mapButton.title = ""
        }

        configureDetailViewController()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = ""
        
        configureDetailViewController()
        
        let (html, geoplaces) = ScriptureRenderer.sharedRenderer.htmlForBookId(bookId, chapter: chapter)
        webView.navigationDelegate = self
        webView.loadHTMLString(html, baseURL: nil)
        MapConfiguration.sharedConfig.pins = geoplaces
        if let mapVC = mapViewController {
            mapVC.addPins()
        }
    }
    
    // MARK - Navigation delegate
    func webView(_ webView: WKWebView,
                    decidePolicyFor navigationAction: WKNavigationAction,
                    decisionHandler: @escaping (WKNavigationActionPolicy) -> Void) {
        if let path = navigationAction.request.url?.absoluteString {
            let baseUrl = ScriptureRenderer.Constant.baseUrl
            
            if path.hasPrefix(baseUrl) {
                if let geoplaceId = Int(path.substring(fromOffset: baseUrl.count)) {
                    print(geoplaceId)
                    MapConfiguration.sharedConfig.selectedLocationId = geoplaceId
                    if let mapVC = mapViewController {
                        mapVC.showSelectedPin()
                    }
                }
                if mapViewController == nil {
                    
                } else {
                    
                }
                
                decisionHandler(.cancel)
                return
            }
        }
        
        decisionHandler(.allow)
    }
    
    // MARK - Helpers
    private func configureDetailViewController() {
        if let splitVC = splitViewController {
            if let navVC = splitVC.viewControllers.last as? UINavigationController {
                mapViewController = navVC.topViewController as? MapViewController
            }
        } else {
            mapViewController = nil
        }
    }
}
