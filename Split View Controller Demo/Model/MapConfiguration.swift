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
    var pins = [GeoPlace]() {
        didSet{
            let maxLat = pins.map { $0.latitude }.max()
            let maxLong = pins.map { $0.longitude }.max()
            let minLat = pins.map { $0.latitude }.min()
            let minLong = pins.map { $0.longitude }.min()
            if let maxLat = maxLat, let minLat = minLat, let minLong = minLong, let maxLong = maxLong {
                let centerLatitude = (maxLat + minLat) / 2
                let centerLongitude = (maxLong + minLong) / 2
                MapConfiguration.sharedConfig.centerLatitude = centerLatitude
                MapConfiguration.sharedConfig.centerLongitude = centerLongitude
                MapConfiguration.sharedConfig.deltaLatitude = maxLat - minLat
                MapConfiguration.sharedConfig.deltaLongitude = maxLong - minLong
            }
            print(MapConfiguration.sharedConfig.centerLongitude, MapConfiguration.sharedConfig.centerLatitude)
        }
    }
    var selectedLocationId = 0
    var selected = false
    var centerLatitude = 40.770473
    var centerLongitude = -111.891802
    var deltaLongitude = 0.2
    var deltaLatitude = 0.2
}
