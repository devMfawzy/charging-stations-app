//
//  LocationCoordinate.swift
//  ChargingStations
//
//  Created by Mohamed Fawzy on 21/08/2022.
//

import Foundation

struct LocationCoordinate: Equatable {
    let latitude: Double
    let longitude: Double
}

// MARK: default location
extension LocationCoordinate {
    static var defaultCoordinate: LocationCoordinate {
        LocationCoordinate(latitude: 51.1657, longitude: 10.4515)
    }
    
    static var defaultSpan: LocationCoordinate {
        LocationCoordinate(latitude: 51.1657, longitude: 10.4515)
    }
}
