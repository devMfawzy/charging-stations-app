//
//  PointOfInterestBO.swift
//  ChargingStations
//
//  Created by Mohamed Fawzy on 21/08/2022.
//

import Foundation

struct PointOfInterestBO: Identifiable {
    let id: Int
    let title: String
    let coordinate: LocationCoordinate
    let info: [InfoItem]
    
    init(dto: PointOfInterestDTO) {
        self.id = dto.id
        self.title = dto.addressInfo.title
        self.coordinate = LocationCoordinate(latitude: dto.addressInfo.latitude, longitude: dto.addressInfo.longitude)
        var address = dto.addressInfo.addressLine1 ?? .empty
        if let addressLine2 = dto.addressInfo.addressLine2 {
            address += .addressLineSeparator
            address += addressLine2
        }
        self.info = [
            InfoItem(title: .chargingPointsCount, value: String(dto.numberOfChargingPoints ?? 0)),
            InfoItem(title: .address, value: address)
        ]
    }
    
    init(id: Int, title: String, coordinate: LocationCoordinate, info: [InfoItem]) {
        self.id = id
        self.title = title
        self.coordinate = coordinate
        self.info = info
    }
    
    struct InfoItem: Identifiable {
        let title: String
        let value: String
        var id: String {
            title
        }
    }
}
