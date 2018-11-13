//
//  MapViewController.swift
//  Split View Controller Demo
//
//  Created by Kyle Gill on 11/12/18.
//  Copyright © 2018 IS 543. All rights reserved.
//

import UIKit

class MapViewController : UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let splitVC = splitViewController {
            navigationItem.leftItemsSupplementBackButton = true
            navigationItem.leftBarButtonItem = splitVC.displayModeButtonItem
        }
    }
}
