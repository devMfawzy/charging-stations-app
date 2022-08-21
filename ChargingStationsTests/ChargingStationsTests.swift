//
//  ChargingStationsTests.swift
//  ChargingStationsTests
//
//  Created by Mohamed Fawzy on 21/08/2022.
//

import XCTest
import Combine
@testable import ChargingStations

class ChargingStationsTests: XCTestCase {
    private var service: ChargingStationsServiceProtocol!
    private var cancellables = Set<AnyCancellable>()
    private var viewModel: ChargingStationsViewModel!

    override func setUpWithError() throws {
        self.service = MockChargingStationService()
        self.viewModel = ChargingStationsViewModel(service: service)
    }

    override func tearDown() {
        cancellables.forEach { $0.cancel()}
        cancellables.removeAll()
        service = nil
        viewModel = nil
        super.tearDown()
    }

    func test_beforeFetchingData_stateShouldBe_idle() {
        // given / not calling any fetch request yet, it should be on idle state as default state
        // then
        XCTAssertEqual(viewModel.state, .idle)
    }
    
    func test_whileFetchingWithNoResponseYet_stateShouldBe_loading() {
        // given
        if let service = service as? MockChargingStationService {
            service.data = nil
            service.error = nil
        }
        // when
        viewModel.fetchPOIs()
        // then
        XCTAssertEqual(viewModel.state, .loading)
    }
    
    func test_whileResultIsEmpty_stateShouldBe_errorOfEmptyData() {
        // given
        if let service = service as? MockChargingStationService {
            service.data = []
        }
        // when
       let expectation = expectation(description: "expect emptyDataSet error")
        viewModel.fetchPOIs()
        DispatchQueue.main.asyncAfter(deadline: .now()+0.1) {
            expectation.fulfill()
        }
        waitForExpectations(timeout: 3)
        // then
        XCTAssertEqual(viewModel.state, .error(.emptyDataSet))
    }
    
    func test_whileResultHasOnePOI_stateShouldBe_finishedLoading() {
        // given
        let id = randomInt
        let title = randomString(length: 33)
        let lat = randomDouble
        let long = randomDouble
        if let service = service as? MockChargingStationService {
            service.data = [
                PointOfInterestDTO(id: id, addressInfo: AddressInfoDTO(title: title, latitude: lat, longitude: long))
            ]
        }
        // when
       let expectation = expectation(description: "expect have one POI finishedLoading successfully")
        viewModel.fetchPOIs()
        let date = Date()
        DispatchQueue.main.asyncAfter(deadline: .now()+0.1) {
            expectation.fulfill()
        }
        waitForExpectations(timeout: 1)
        // then
        let message = String.updateAtMessage(date: date)
        XCTAssertEqual(viewModel.state, ViewModelState.finishedLoading(message))
        XCTAssertEqual(viewModel.poiList.count, 1)
        let poi = viewModel.poiList.first!
        XCTAssertEqual(poi.id, id)
        XCTAssertEqual(poi.title, title)
        XCTAssertEqual(poi.coordinate.latitude, lat)
        XCTAssertEqual(poi.coordinate.longitude, long)
    }
    
    func test_DTO_ifNumberOfChargingPoints_isNil_BusinessObject_should_haveNumberOfChargingPoints_equal_0() {
        // given
        let dto = PointOfInterestDTO(id: 2132, addressInfo: AddressInfoDTO(title: randomString(length: 22), latitude: randomDouble, longitude: randomDouble), numberOfChargingPoints: nil)
        // when
        let bo = PointOfInterestBO(dto: dto)
        // then
        XCTAssertTrue(bo.info.contains(where: { $0.title == String.chargingPointsCount && $0.value == "0"}))
    }
    
    func test_DTO_ifNumberOfChargingPoints_isNotNull_BusinessObject_should_haveTheSameNumberOfChargingPoints() {
        let range = 1...1000
        for _ in range {
            let i = randomInt
            // given
            let dto = PointOfInterestDTO(id: i, addressInfo: AddressInfoDTO(title: randomString(length: 25), latitude: randomDouble, longitude: randomDouble), numberOfChargingPoints: i)
            // when
            let bo = PointOfInterestBO(dto: dto)
            // then
            XCTAssertTrue(bo.info.contains(where: { $0.title == String.chargingPointsCount && $0.value == String(i)}))
        }
    }
    
    func test_DTO_ifAddressLine1AndLine2_areNil_BusinessObject_shouldHasNo_address_info() {
        // given
        let dto = PointOfInterestDTO(id: randomInt, addressInfo: AddressInfoDTO(title: randomString(length: 43), addressLine1: nil, addressLine2: nil, latitude: randomDouble, longitude: randomDouble))
        // when
        let bo = PointOfInterestBO(dto: dto)
        // then
        XCTAssertFalse(bo.info.contains(where: { $0.title == String.address }))
    }
    
    func test_DTO_ifAddressLine2_isNil_BusinessObject_shouldHas_OneLineOfAdressInfo() {
        // given
        let addressLine1 = randomString(length: 33)
        let dto = PointOfInterestDTO(id: randomInt, addressInfo: AddressInfoDTO(title: randomString(length: 22), addressLine1: addressLine1, addressLine2: nil, latitude: randomDouble, longitude: randomDouble))
        // when
        let bo = PointOfInterestBO(dto: dto)
        // then
        XCTAssertTrue(bo.info.contains(where: { $0.title == String.address && $0.value == addressLine1 }))
    }
    
    func test_DTO_ifAddressLine1_isNil_BusinessObject_shouldHas_OneLineOfAdressInfo() {
        // given
        let addressLine2 = randomString(length: 30)
        let dto = PointOfInterestDTO(id: randomInt, addressInfo: AddressInfoDTO(title: randomString(length: 40), addressLine1: nil, addressLine2: addressLine2, latitude: randomDouble, longitude: randomDouble))
        // when
        let bo = PointOfInterestBO(dto: dto)
        // then
        XCTAssertTrue(bo.info.contains(where: { $0.title == String.address && $0.value == addressLine2 }))
    }
    
    func test_DTO_ifAddressLine1And2_areNotNil_BusinessObject_shouldHas_2LinesOfAdressInfo() {
        // given
        let addressLine1 = randomString(length: 23)
        let addressLine2 = randomString(length: 12)
        let dto = PointOfInterestDTO(id: randomInt, addressInfo: AddressInfoDTO(title: randomString(length: 30), addressLine1: addressLine1, addressLine2: addressLine2, latitude: randomDouble, longitude: randomDouble))
        // when
        let bo = PointOfInterestBO(dto: dto)
        // then
        XCTAssertTrue(bo.info.contains(where: { $0.title == String.address && $0.value == addressLine1+",\n"+addressLine2}))
    }
    
    
}

extension ChargingStationsTests {
    var randomInt: Int {
        Int.random(in: 0...10000)
    }
    
    var randomDouble: Double {
        Double.random(in: 1.1111...55.5555)
    }
    
    func randomString(length: Int) -> String {
      let letters = "0123456789abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ"
      return String((0..<length).map{ _ in letters.randomElement()! })
    }
    
    func test_ifRequestGorEmptyDataError_stateShouldBe_emptyDataSetError() {
        // given
        if let service = service as? MockChargingStationService {
            service.error = .emptyDataSet
        }
        // when
       let expectation = expectation(description: "expect have one POI finishedLoading successfully")
        viewModel.fetchPOIs()
        DispatchQueue.main.asyncAfter(deadline: .now()+0.1) {
            expectation.fulfill()
        }
        waitForExpectations(timeout: 3)
        // then
        XCTAssertTrue(viewModel.poiList.isEmpty)
        XCTAssertEqual(viewModel.state, .error(.emptyDataSet))
    }
    
    func test_ifRequestGorNetworkError_stateShouldBe_networkError() {
        // given
        if let service = service as? MockChargingStationService {
            service.error = .network
        }
        // when
       let expectation = expectation(description: "expect have one POI finishedLoading successfully")
        viewModel.fetchPOIs()
        DispatchQueue.main.asyncAfter(deadline: .now()+0.1) {
            expectation.fulfill()
        }
        waitForExpectations(timeout: 3)
        // then
        XCTAssertTrue(viewModel.poiList.isEmpty)
        XCTAssertEqual(viewModel.state, .error(.network))
    }
    
    func test_ifParsingDataFailed_shouldGet_parsingError() {
        // given
        if let service = service as? MockChargingStationService {
            service.error = .parsing
        }
        // when
       let expectation = expectation(description: "expect have one POI finishedLoading successfully")
        viewModel.fetchPOIs()
        DispatchQueue.main.asyncAfter(deadline: .now()+0.1) {
            expectation.fulfill()
        }
        waitForExpectations(timeout: 3)
        // then
        XCTAssertTrue(viewModel.poiList.isEmpty)
        XCTAssertEqual(viewModel.state, .error(.parsing))
    }
    
    func test_ifUndefinedErrorReceived_shouldGet_unknownError() {
        // given
        if let service = service as? MockChargingStationService {
            service.error = .unknown
        }
        // when
       let expectation = expectation(description: "expect have one POI finishedLoading successfully")
        viewModel.fetchPOIs()
        DispatchQueue.main.asyncAfter(deadline: .now()+0.1) {
            expectation.fulfill()
        }
        waitForExpectations(timeout: 3)
        // then
        XCTAssertTrue(viewModel.poiList.isEmpty)
        XCTAssertEqual(viewModel.state, .error(.unknown))
    }
}
