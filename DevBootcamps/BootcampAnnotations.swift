//
//  BootcampAnnotations.swift
//  DevBootcamps
//
//  Created by marvin evins on 6/5/16.
//  Copyright © 2016 marvin evins. All rights reserved.
//

import Foundation

import MapKit


class BootcampAnnotation: NSObject, MKAnnotation {
    var coordinate = CLLocationCoordinate2D()
    init(coordinate:CLLocationCoordinate2D) {
        self.coordinate = coordinate
    }
}
