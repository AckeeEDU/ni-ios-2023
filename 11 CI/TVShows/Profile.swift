//
//  Profile.swift
//  TVShows
//
//  Created by Igor Rosocha on 22.03.2023.
//

import Foundation

struct Profile: Decodable, Equatable {
    let name: String
    let username: String
    let vip: Bool
    let joinedAt: String
    let location: String
    let age: Int
}
