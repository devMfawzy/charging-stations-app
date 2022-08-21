//
//  ChargingStationsModelTests.swift
//  ChargingStationsTests
//
//  Created by Mohamed Fawzy on 21/08/2022.
//

import XCTest
@testable import ChargingStations

class ChargingStationsModelTests: XCTestCase {
    
    var sut: ChargingStations!
    
    override func tearDown()  {
        sut = nil
        super.tearDown()
    }

    func test_whenStationsList_is_empty() {
        // Given
        let dtos = [PointOfInterestDTO]()
        // when
        sut = ChargingStations(dtos: dtos)
        // then
        XCTAssertTrue(sut.poiList.isEmpty)
        XCTAssertNil(sut.centerCoordinate)
    }
    
    func test_whenOneStation_isGiven() {
        // Given
        let lat = randomDouble
        let long = randomDouble
        let poi = PointOfInterestDTO(id: randomInt, addressInfo: AddressInfoDTO(title: randomString(length: 43), latitude: lat, longitude: long))
        let dtos = [poi]
        // when
        sut = ChargingStations(dtos: dtos)
        // then
        XCTAssertEqual(sut.poiList.count, 1)
        XCTAssertEqual(sut.centerCoordinate, LocationCoordinate(latitude: lat, longitude: long))
    }
    
    func test_whenTwoStations_isGiven() {
        // Given
        let lat1 = randomDouble
        let long1 = randomDouble
        let lat2 = randomDouble
        let long2 = randomDouble
        let poi1 = PointOfInterestDTO(id: randomInt, addressInfo: AddressInfoDTO(title: randomString(length: 43), latitude: lat1, longitude: long1))
        let poi2 = PointOfInterestDTO(id: randomInt, addressInfo: AddressInfoDTO(title: randomString(length: 43), latitude: lat2, longitude: long2))
        let dtos = [poi1, poi2]
        // when
        sut = ChargingStations(dtos: dtos)
        // then
        XCTAssertEqual(sut.poiList.count, 2)
        XCTAssertEqual(sut.centerCoordinate, LocationCoordinate(latitude: (lat1+lat2)/2, longitude: (long1+long2)/2))
    }
    
}
