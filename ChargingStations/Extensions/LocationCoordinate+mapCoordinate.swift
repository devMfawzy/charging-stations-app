//
//  LocationCoordinate+mapCoordinate.swift
//  ChargingStations
//
//  Created by Mohamed Fawzy on 21/08/2022.
//

import Foundation
import CoreLocation

extension LocationCoordinate {
    var mapCoordinate: CLLocationCoordinate2D {
        CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
    }
}
