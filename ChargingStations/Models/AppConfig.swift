//
//  AppConfig.swift
//  ChargingStations
//
//  Created by Mohamed Fawzy on 21/08/2022.
//

import Foundation

struct AppConfig {
    static var coordinateSpan = CoordinateSpan(latitudeDelta: 0.04, longitudeDelta: 0.04)
    static var updateAfterTimeInterval: TimeInterval = 30
    
    struct CoordinateSpan {
        let latitudeDelta: Double
        let longitudeDelta: Double
    }
}
