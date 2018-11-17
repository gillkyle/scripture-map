//
//  MapViewController.swift
//  Split View Controller Demo
//
//  Created by Kyle Gill on 11/12/18.
//  Copyright © 2018 IS 543. All rights reserved.
//

import UIKit
import MapKit

class MapViewController : UIViewController {
    // MARK - Constants
    private struct Constant {
        static let AnnotationReuseIdentifier = "MapPin"
    }
    
    // MARK - Outlets
    @IBOutlet weak var mapView: MKMapView!
    
    // MARK - View Controller Lifecycle methods
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let splitVC = splitViewController {
            navigationItem.leftItemsSupplementBackButton = true
            navigationItem.leftBarButtonItem = splitVC.displayModeButtonItem
        }
        
        mapView.register(MKPinAnnotationView.self, forAnnotationViewWithReuseIdentifier: Constant.AnnotationReuseIdentifier)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        let center = CLLocationCoordinate2DMake(MapConfiguration.sharedConfig.centerLatitude, MapConfiguration.sharedConfig.centerLongitude)
        let camera = MKMapCamera(lookingAtCenter: center, fromEyeCoordinate: center, eyeAltitude: 500)
        
        mapView.setCamera(camera, animated: true)
        
        addPins()
    }
    
    // MARK - Actions
    func showSelectedPin() {
        if let location = GeoDatabase.sharedGeoDatabase.geoPlaceForId(MapConfiguration.sharedConfig.selectedLocationId) {
            print(location)
            let annotation = MKPointAnnotation()
            annotation.coordinate = CLLocationCoordinate2DMake(location.latitude, location.longitude)
            annotation.title = location.placename
            mapView.addAnnotation(annotation)
        }
        
    }
    func addPins() {
        removeAnnotations()
        for location in MapConfiguration.sharedConfig.pins {
            print(location.placename)
            let annotation = MKPointAnnotation()
            annotation.coordinate = CLLocationCoordinate2DMake(location.latitude, location.longitude)
            annotation.title = location.placename
            mapView.addAnnotation(annotation)
        }
        setRegion()
    }
    
    // MARK - Map View Delegate
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        let view = mapView.dequeueReusableAnnotationView(withIdentifier: Constant.AnnotationReuseIdentifier, for: annotation)
        if let pinView = view as? MKPinAnnotationView {
            pinView.canShowCallout = true
            pinView.animatesDrop = true
            pinView.pinTintColor = .purple
        }
        
        return view
    }
    
    // MARK - Helpers
    private func removeAnnotations() {
        let allAnnotations = mapView.annotations
        mapView.removeAnnotations(allAnnotations)
    }
    private func setRegion() {
        let center = CLLocationCoordinate2DMake(MapConfiguration.sharedConfig.centerLatitude, MapConfiguration.sharedConfig.centerLongitude)
        
        let span = MKCoordinateSpan(latitudeDelta: MapConfiguration.sharedConfig.deltaLatitude, longitudeDelta: MapConfiguration.sharedConfig.deltaLongitude)
        let viewRegion = MKCoordinateRegion(center: center, span: span)
        mapView.setRegion(viewRegion, animated: true)
        mapView.showAnnotations(mapView.annotations, animated: true)
    }
}
