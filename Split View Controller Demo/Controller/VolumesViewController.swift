//
//  MasterViewController.swift
//  Split View Controller Demo
//
//  Created by Steve Liddle on 11/1/18.
//  Copyright © 2018 IS 543. All rights reserved.
//

import UIKit

class VolumesViewController : UITableViewController {

    private struct Storyboard {
        static let VolumeCellIdentifier = "VolumeCell"
        static let ShowBooksSegue = "ShowBooks"
    }

    var volumes = GeoDatabase.sharedGeoDatabase.volumes()

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == Storyboard.ShowBooksSegue {
            if let booksVC = segue.destination as? BooksViewController {
                if let indexPath = sender as? IndexPath {
                    booksVC.volume = volumes[indexPath.row]
                    booksVC.volumeId = indexPath.row + 1
                }
            }
        }
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return volumes.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: Storyboard.VolumeCellIdentifier, for: indexPath)

        cell.textLabel?.text = volumes[indexPath.row]

        return cell
    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: Storyboard.ShowBooksSegue, sender: indexPath)
    }
}
