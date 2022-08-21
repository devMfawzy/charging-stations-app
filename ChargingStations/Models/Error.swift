//
//  Error.swift
//  ChargingStations
//
//  Created by Mohamed Fawzy on 21/08/2022.
//

import Foundation

enum Error: Swift.Error, CustomStringConvertible, Equatable {
    case network
    case parsing
    case emptyDataSet
    case unknown
  
    var description: String {
        switch self {
        case .network:
            return "Request to API server failed"
        case .parsing:
            return "Failed parsing response from server"
        case .emptyDataSet:
            return "No points of interest available yet"
        case .unknown:
            return "An unknown error occurred"
        }
    }
}
