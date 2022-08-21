//
//  String+Custom.swift
//  ChargingStations
//
//  Created by Mohamed Fawzy on 21/08/2022.
//

import Foundation

extension String {
    static var empty: String {
        ""
    }
    
    static var addressLineSeparator: String {
        ",\n"
    }
    
    static var address: String {
        "Address"
    }
    
    static var chargingPointsCount: String {
        "Number Of Charging Points"
    }
    
    static var updatedAt: String {
        "Updated at"
    }
}

// MARK: Update At Message

extension String {
    static func updateAtMessage(date: Date) -> String {
        let formatter = DateFormatter()
        formatter.timeStyle = .medium
        let time = formatter.string(from: date)
        return String.updatedAt + " " + time
    }
}
