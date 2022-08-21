//
//  ChargingStationsApp.swift
//  ChargingStations
//
//  Created by Mohamed Fawzy on 21/08/2022.
//

import SwiftUI

@main
struct ChargingStationsApp: App {
    var body: some Scene {
        WindowGroup {
            MapView()
                .environmentObject(ChargingStationsViewModel())
        }
    }
}
