//
//  BooksViewController.swift
//  Split View Controller Demo
//
//  Created by Kyle Gill on 11/6/18.
//  Copyright © 2018 IS 543. All rights reserved.
//

import UIKit

class BooksViewController : UITableViewController {
    // MARK - Constants
    private struct Storyboard {
        static let BookCellIdentifier = "BookCell"
        static let ShowScripturesSegueIdentifier = "ShowChapterContent"
    }
    
    // MARK - Properties
    var books = [Book]()
    var volume = ""
    var volumeId = 1
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        updateModel()
   }
    
    // MARK - Segues
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let scripVC = segue.destination as? ScripturesViewController {
            if let indexPath = sender as? IndexPath {
                scripVC.bookId = books[indexPath.row].id
                scripVC.chapter = 7
            }
        }
    }
    
    // MARK - Table View data source
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
        performSegue(withIdentifier: Storyboard.ShowScripturesSegueIdentifier, sender: indexPath)
    }
    
    // MARK - Helpers
    private func updateModel() {
        title = volume
        books = GeoDatabase.sharedGeoDatabase.booksForParentId(volumeId)
    }
}
