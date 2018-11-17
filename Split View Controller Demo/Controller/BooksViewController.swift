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
        static let ShowChaptersSegueIdentifier = "ShowChapterList"
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
                MapConfiguration.sharedConfig.selected = false
                scripVC.bookId = books[indexPath.row].id
                scripVC.chapter = books[indexPath.row].numChapters ?? 0
            }
        }
        if let chapterVC = segue.destination as? ChaptersViewController {
            if let indexPath = sender as? IndexPath {
                chapterVC.bookId = books[indexPath.row].id
                chapterVC.bookName = books[indexPath.row].fullName
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
        if (books[indexPath.row].numChapters ?? 0 < 2) {
            performSegue(withIdentifier: Storyboard.ShowScripturesSegueIdentifier, sender: indexPath)
        } else {
            performSegue(withIdentifier: Storyboard.ShowChaptersSegueIdentifier, sender: indexPath)
        }
    }
    
    // MARK - Helpers
    private func updateModel() {
        title = volume
        books = GeoDatabase.sharedGeoDatabase.booksForParentId(volumeId)
    }
}
