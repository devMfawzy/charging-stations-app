//
//  Error_Tests.swift
//  ChargingStationsTests
//
//  Created by Mohamed Fawzy on 21/08/2022.
//

import XCTest
@testable import ChargingStations

class Error_Tests: XCTestCase {

    func test_unknownError_description() {
        XCTAssertEqual(Error.unknown.description, String.unknownError)
    }
    
    func test_parsingError_description() {
        XCTAssertEqual(Error.parsing.description, String.parsingError)
    }
    
    func test_networkError_description() {
        XCTAssertEqual(Error.network.description, String.networkError)
    }
    
    func test_emptyDataSetError_description() {
        XCTAssertEqual(Error.emptyDataSet.description, String.emptyDataError)
    }
}
