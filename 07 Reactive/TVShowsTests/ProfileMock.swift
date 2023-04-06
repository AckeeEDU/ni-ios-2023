//
//  ProfileMock.swift
//  TVShowsTests
//
//  Created by Igor Rosocha on 22.03.2023.
//

import Foundation

@testable import TVShows

extension Profile {
    static var mock: Self {
        .init(
            name: "Igor",
            username: "igor",
            vip: false,
            joinedAt: "2022-12-08T04:20:58.000Z",
            location: "Vicenza, Veneto",
            age: 26
        )
    }
}
