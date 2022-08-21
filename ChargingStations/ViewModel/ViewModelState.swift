//
//  ViewModelState.swift
//  ChargingStations
//
//  Created by Mohamed Fawzy on 21/08/2022.
//

import Foundation

enum ViewModelState: Equatable {
    case idle
    case loading
    case finishedLoading(String)
    case error(Error)
}
