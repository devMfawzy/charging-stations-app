//
//  PointOfInterestDTO.swift
//  ChargingStations
//
//  Created by Mohamed Fawzy on 21/08/2022.
//

import Foundation

struct PointOfInterestDTO: Decodable {
    var id: Int
    var addressInfo: AddressInfoDTO
    var numberOfChargingPoints: Int?
    
    private enum CodingKeys : String, CodingKey {
        case id = "ID"
        case addressInfo = "AddressInfo"
        case numberOfChargingPoints = "NumberOfPoints"
    }
}
