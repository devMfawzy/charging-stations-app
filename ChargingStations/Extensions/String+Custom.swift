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
    
    static var retry: String {
        "Retry"
    }
    
    static var waiting: String {
        "Waiting..."
    }
    
    static var done: String {
        "Done"
    }
    
    static var networkError: String {
        "Request to API server failed"
    }
    
    static var parsingError: String {
        "Failed parsing response from server"
    }
    
    static var emptyDataError: String {
        "No points of interest available yet"
    }
    
    static var unknownError: String {
        "An unknown error occurred"
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
