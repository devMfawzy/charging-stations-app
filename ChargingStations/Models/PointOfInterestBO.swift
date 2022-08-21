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
    var info: [InfoItem] = []
    
    init(dto: PointOfInterestDTO) {
        self.id = dto.id
        self.title = dto.operatorInfo?.title ?? dto.addressInfo.title
        self.coordinate = LocationCoordinate(latitude: dto.addressInfo.latitude, longitude: dto.addressInfo.longitude)
        self.info.append(InfoItem(title: .chargingPointsCount, value: String(dto.numberOfChargingPoints ?? 0)))
        var address = dto.addressInfo.addressLine1 ?? .empty
        if let addressLine2 = dto.addressInfo.addressLine2 {
            if !address.isEmpty {
                address += .addressLineSeparator
            }
            address += addressLine2
        }
        if !address.isEmpty {
            self.info.append(InfoItem(title: .address, value: address))
        }
    }
    
    init(id: Int, title: String, coordinate: LocationCoordinate, info: [InfoItem]) {
        self.id = id
        self.title = title
        self.coordinate = coordinate
        self.info = info
    }
    
    struct InfoItem: Identifiable {
        let id = UUID()
        let title: String
        let value: String
    }
}
