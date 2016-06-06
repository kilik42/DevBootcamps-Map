//
//  SecondViewController.swift
//  DevBootcamps
//
//  Created by marvin evins on 6/4/16.
//  Copyright © 2016 marvin evins. All rights reserved.
//

import UIKit
import MapKit

class LocationVC: UIViewController, UITableViewDataSource, UITableViewDelegate, MKMapViewDelegate {

    
    @IBOutlet weak var tableView: UITableView!
    
    @IBOutlet weak var map: MKMapView!
    
    let locationManager = CLLocationManager()
    
    let regionRadius: CLLocationDistance = 1000
    
    let addresses = [
        "10 W 33rd St, Chicago, IL 60616",
        "201 E Randolph St, Chicago, IL 60602",
        "5841 S Maryland Ave, Chicago, IL 60637"
    ]
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        map.delegate = self
        tableView.delegate = self
        tableView.dataSource = self
        
        for add in addresses {
            getPlacemarkFromAddress(add)
        }
        
    }

    override func viewDidAppear(animated: Bool) {
        locationAuthStatus()
    }
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        return UITableViewCell()
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func locationAuthStatus(){
        if CLLocationManager.authorizationStatus() == .AuthorizedWhenInUse{
            map.showsUserLocation = true
        } else {
            locationManager.requestWhenInUseAuthorization()
        }
    }
    
    func centerMapOnLocation(location: CLLocation){
        let coordinateRegion = MKCoordinateRegionMakeWithDistance(location.coordinate, regionRadius * 2, regionRadius * 2)
        map.setRegion(coordinateRegion, animated: true)
    }
    
    func mapView(mapView: MKMapView, didUpdateUserLocation userLocation: MKUserLocation) {
        if let loc = userLocation.location{
            centerMapOnLocation(loc)
        }
    }
    
    func mapView(mapView: MKMapView, viewForAnnotation annotation: MKAnnotation) -> MKAnnotationView? {
        if annotation.isKindOfClass(BootcampAnnotation){
            
            let annoView = MKPinAnnotationView(annotation: annotation, reuseIdentifier: "Default")
            annoView.pinTintColor = UIColor.yellowColor()
            annoView.animatesDrop = true
            return annoView
        }else if annotation.isKindOfClass(MKUserLocation){
            return nil
        }
        return nil
    }
    
    func createAnnotationForLocation(location:CLLocation){
        
        let bootcamp = BootcampAnnotation(coordinate: location.coordinate)
        map.addAnnotation(bootcamp)
    }
    
    func getPlacemarkFromAddress(address: String) {
        CLGeocoder().geocodeAddressString(address) { (placemarks: [CLPlacemark]?, error: NSError? ) -> Void in
            if let marks = placemarks where marks.count > 0 {
                if let loc = marks[0].location{
                    //we have a valid location with coordinates
                    self.createAnnotationForLocation(loc)
                }
            }
        }
    }
}

