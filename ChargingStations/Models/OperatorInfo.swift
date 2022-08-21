//
//  OperatorInfo.swift
//  ChargingStations
//
//  Created by Mohamed Fawzy on 21/08/2022.
//

import Foundation

struct OperatorInfo: Decodable {
    var title: String
    
    private enum CodingKeys : String, CodingKey {
        case title = "Title"
    }
}
