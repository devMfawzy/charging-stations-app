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
            return .networkError
        case .parsing:
            return .parsingError
        case .emptyDataSet:
            return .emptyDataError
        case .unknown:
            return .unknownError
        }
    }
}
