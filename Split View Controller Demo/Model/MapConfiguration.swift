//
//  MapConfiguration.swift
//  Split View Controller Demo
//
//  Created by Kyle Gill on 11/15/18.
//  Copyright © 2018 IS 543. All rights reserved.
//

import Foundation

class MapConfiguration {
    // MARK: - Singleton
    static let sharedConfig = MapConfiguration()
    
    // MARK: - Properties
    var hasMapButton = false
    var pins = [GeoPlace]()
    var selectedLocationId = 0
    var selected = false

}
