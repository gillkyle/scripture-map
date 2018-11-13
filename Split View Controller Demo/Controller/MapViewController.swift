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
        
        let annotation = MKPointAnnotation()
        
        annotation.coordinate = CLLocationCoordinate2DMake(40, -111)
        annotation.title = "Tanner Building"
        annotation.subtitle = "BYU Campus"
        
        mapView.addAnnotation(annotation)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        let camera = MKMapCamera(lookingAtCenter: CLLocationCoordinate2DMake(40, -111), fromEyeCoordinate: CLLocationCoordinate2DMake(40, -111), eyeAltitude: 500)
        
        mapView.setCamera(camera, animated: true)
        
        let center = CLLocationCoordinate2DMake(40, -111)
        let span = MKCoordinateSpan(latitudeDelta: 0.02, longitudeDelta: 0.02)
        let viewRegion = MKCoordinateRegion(center: center, span: span)
        
        mapView.setRegion(viewRegion, animated: true)
        mapView.showAnnotations(mapView.annotations, animated: true)
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
}
