//
//  ChaptersViewController.swift
//  Split View Controller Demo
//
//  Created by Kyle Gill on 11/15/18.
//  Copyright © 2018 IS 543. All rights reserved.
//

import UIKit

class ChaptersViewController : UITableViewController {
    // MARK - Constants
    private struct Storyboard {
        static let ChapterCellIdentifier = "ChapterCell"
        static let ShowScripturesSegueIdentifier = "ShowChapterContent"
    }
    
    // MARK - Properties
    var bookName = ""
    var book = Book()
    var bookId = 1
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
        updateModel()
    }
    
    // MARK - Segues
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let scripVC = segue.destination as? ScripturesViewController {
            if let indexPath = sender as? IndexPath {
                scripVC.chapter = indexPath.row + 1
                scripVC.bookId = bookId
            }
        }
    }
    
    // MARK - Table View data source
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) ->
        Int {
            return book.numChapters ?? 0
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: Storyboard.ChapterCellIdentifier, for: indexPath)
        
        cell.textLabel?.text = "Chapter \(String(indexPath.item + 1))"
        return cell
    }
    
    
    // MARK - Table view delegate
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        MapConfiguration.sharedConfig.selected = false
        performSegue(withIdentifier: Storyboard.ShowScripturesSegueIdentifier, sender: indexPath)
    }
    
    // MARK - Helpers
    private func updateModel() {
        title = bookName
        book = GeoDatabase.sharedGeoDatabase.bookForId(bookId)
    }
}

