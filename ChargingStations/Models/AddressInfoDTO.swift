//
//  AddressInfoDTO.swift
//  ChargingStations
//
//  Created by Mohamed Fawzy on 21/08/2022.
//

import Foundation

struct AddressInfoDTO: Decodable {
    var title: String
    var addressLine1: String?
    var addressLine2: String?
    var latitude: Double
    var longitude: Double
    
    private enum CodingKeys : String, CodingKey {
        case title = "Title"
        case addressLine1 = "AddressLine1"
        case addressLine2 = "AddressLine2"
        case latitude = "Latitude"
        case longitude = "Longitude"
    }
}
