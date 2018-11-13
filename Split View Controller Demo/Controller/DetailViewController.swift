//
//  DetailViewController.swift
//  Split View Controller Demo
//
//  Created by Steve Liddle on 11/1/18.
//  Copyright © 2018 IS 543. All rights reserved.
//

import UIKit

class DetailViewController : UIViewController {

    var name = "Unknown"

    @IBOutlet weak var nameLabel: UILabel!

    override func viewDidLoad() {
        super.viewDidLoad()

        if let splitVC = splitViewController {
            navigationItem.leftItemsSupplementBackButton = true
            navigationItem.leftBarButtonItem = splitVC.displayModeButtonItem
        }

        updateUI()
    }

    private func updateUI() {
        nameLabel.text = name
    }
}
