//
//  MockChargingStationService.swift
//  ChargingStationsTests
//
//  Created by Mohamed Fawzy on 21/08/2022.
//

import Foundation
import Combine
@testable import ChargingStations

final class MockChargingStationService: ChargingStationsServiceProtocol {
    private let subject = PassthroughSubject<[PointOfInterestDTO], Error>()
    var data: [PointOfInterestDTO]?
    var error: Error?
    
    func poiList() -> AnyPublisher<[PointOfInterestDTO], Error> {
        DispatchQueue.main.async { [weak self] in
            guard let self = self else { return }
            if let error = self.error {
                self.subject.send(completion: .failure(error))
            } else if let data = self.data {
                self.subject.send(data)
            }
        }
        return subject.eraseToAnyPublisher()
    }
}
