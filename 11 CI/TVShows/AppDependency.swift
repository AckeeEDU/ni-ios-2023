//
//  AppDependency.swift
//  TVShows
//
//  Created by Igor Rosocha on 22.03.2023.
//

import Foundation

/// Instance of `AppDependency`, which contains `TVShows` dependencies.
let appDependencies = AppDependency()

final class AppDependency {
    lazy var traktAPIService: TraktAPIServicing = TraktAPIService()
}

/// Protocol used when VM/Service has no dependencies.
protocol HasNoDependency {}

// MARK: - Extensions

extension AppDependency: HasTraktAPIService {}
