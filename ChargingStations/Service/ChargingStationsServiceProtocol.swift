//
//  ChargingStationsServiceProtocol.swift
//  ChargingStations
//
//  Created by Mohamed Fawzy on 21/08/2022.
//

import Foundation
import Combine

protocol ChargingStationsServiceProtocol {
    func poiList() -> AnyPublisher<[PointOfInterestDTO], Error>
}
