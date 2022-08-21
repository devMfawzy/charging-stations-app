//
//  ChargingStationsService.swift
//  ChargingStations
//
//  Created by Mohamed Fawzy on 21/08/2022.
//

import Foundation
import Combine

struct ChargingStationsService: ChargingStationsServiceProtocol {
    func poiList() -> AnyPublisher<[PointOfInterestDTO], Error> {
        return URLSession.shared
            .dataTaskPublisher(for: API.url!)
            .map(\.data)
            .decode(type: [PointOfInterestDTO].self, decoder: JSONDecoder())
            .mapError { error -> Error in
                switch error {
                case is URLError:
                    return .network
                case is DecodingError:
                    return .parsing
                default:
                    return .unknown
              }
            }
            .eraseToAnyPublisher()
    }
}
