//
//  BooksViewController.swift
//  Split View Controller Demo
//
//  Created by Kyle Gill on 11/6/18.
//  Copyright © 2018 IS 543. All rights reserved.
//

import UIKit

class BooksViewController : UITableViewController {

    private struct Storyboard {
        static let BookCellIdentifier = "BookCell"
        static let ShowScripturesSegueIdentifier = "ShowChapterContent"
    }
    
    var books = [Book]()
    var volume = ""
    var volumeId = 1 {
        didSet {
            books = GeoDatabase.sharedGeoDatabase.booksForParentId(volumeId)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = volume
    }
    
    // MARK: - Table View data source
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) ->
        Int {
            return books.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: Storyboard.BookCellIdentifier, for: indexPath)
        
        cell.textLabel?.text = books[indexPath.row].fullName
        return cell
    }
    
    
    // MARK - Table view delegate
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: Storyboard.ShowScripturesSegueIdentifier, sender: self)
    }
}
