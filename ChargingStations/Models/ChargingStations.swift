//
//  ChargingStations.swift
//  ChargingStations
//
//  Created by Mohamed Fawzy on 21/08/2022.
//

import Foundation

struct ChargingStations {
    let poiList: [PointOfInterestBO]
    var centerCoordinate: LocationCoordinate?
    
    init(dtos: [PointOfInterestDTO]) {
        self.poiList = dtos.map { PointOfInterestBO(dto: $0) }
        let minLatitude = poiList.map { $0.coordinate.latitude}.min()
        let maxLatitude = poiList.map { $0.coordinate.latitude}.max()
        let minLongitude = poiList.map { $0.coordinate.longitude}.min()
        let maxLongitude = poiList.map { $0.coordinate.longitude}.max()
        if let minLatitude = minLatitude, let maxLatitude = maxLatitude, let minLongitude = minLongitude, let maxLongitude = maxLongitude {
            self.centerCoordinate = LocationCoordinate(latitude: (minLatitude+maxLatitude)/2, longitude: (minLongitude+maxLongitude)/2)
        }
    }
}
