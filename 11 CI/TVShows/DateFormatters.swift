//
//  DateFormatters.swift
//  TVShows
//
//  Created by Igor Rosocha on 22.03.2023.
//

import Foundation

enum DateFormatters {
    static let isoFormatter: ISO8601DateFormatter = {
        let formatter = ISO8601DateFormatter()
        formatter.formatOptions = [
            .withInternetDateTime,
            .withFractionalSeconds
        ]
        
        return formatter
    }()
    
    static let joinedFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.setLocalizedDateFormatFromTemplate("ddMMYYYY")
        
        return formatter
    }()
}
