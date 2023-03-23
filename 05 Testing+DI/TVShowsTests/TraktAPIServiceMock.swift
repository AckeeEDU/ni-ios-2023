//
//  TraktAPIServiceMock.swift
//  TVShowsTests
//
//  Created by Igor Rosocha on 22.03.2023.
//

import Foundation

@testable import TVShows

final class TraktAPIServiceMock: TraktAPIServicing {
    
    // MARK: - Internal properties
    
    var tokenResponse: TVShows.OAuthResponse
    var trendingShowsResponse: [TVShows.TrendingShow]
    var seasonsForShowResponse: [TVShows.Season]
    var episodesForSeasonResponse: [TVShows.Episode]
    var episodeResponse: TVShows.Episode
    var searchShowsResponse: [TVShows.SearchedShow]
    var showsResponse: [TVShows.SearchedShow]
    var showResponse: TVShows.SearchedShow
    var profileResponse: TVShows.Profile
    
    // MARK: - Initializers
    
    init(
        tokenResponse: OAuthResponse = .init(
            accessToken: "",
            refreshToken: ""
        ),
        trendingShowsResponse: [TrendingShow] = [],
        seasonsForShowResponse: [Season] = [],
        episodesForSeasonResponse: [Episode] = [],
        episodeResponse: Episode = .init(
            number: 1,
            season: 1,
            ids: .init(
                trakt: 1,
                tvdb: nil
            ),
            title: "",
            overview: nil,
            runtime: 1,
            rating: 10.0
        ),
        searchShowsResponse: [SearchedShow] = [],
        showsResponse: [SearchedShow] = [],
        showResponse: SearchedShow = .init(
            show: .init(
                title: "",
                year: 2023,
                ids: .init(
                    trakt: 1,
                    tvdb: nil
                )
            )
        ),
        profileResponse: Profile = .mock
    ) {
        self.tokenResponse = tokenResponse
        self.trendingShowsResponse = trendingShowsResponse
        self.seasonsForShowResponse = seasonsForShowResponse
        self.episodesForSeasonResponse = episodesForSeasonResponse
        self.episodeResponse = episodeResponse
        self.searchShowsResponse = searchShowsResponse
        self.showsResponse = showsResponse
        self.showResponse = showResponse
        self.profileResponse = profileResponse
    }

    func token(code: String) async throws -> TVShows.OAuthResponse {
        tokenResponse
    }
    
    func trendingShows(page: Int) async throws -> [TVShows.TrendingShow] {
        trendingShowsResponse
    }
    
    func seasonsForShow(_ show: TVShows.Show) async throws -> [TVShows.Season] {
        seasonsForShowResponse
    }
    
    func episodesForSeason(_ season: TVShows.Season, show: TVShows.Show) async throws -> [TVShows.Episode] {
        episodesForSeasonResponse
    }
    
    func episode(id: Int, season: TVShows.Season, show: TVShows.Show) async throws -> TVShows.Episode {
        episodeResponse
    }
    
    func searchShows(query: String) async throws -> [TVShows.SearchedShow] {
        searchShowsResponse
    }
    
    func shows(ids: [Int]) async throws -> [TVShows.SearchedShow] {
        showsResponse
    }
    
    func show(id: Int) async throws -> TVShows.SearchedShow {
        showResponse
    }
    
    func profile(name: String) async throws -> TVShows.Profile {
        profileResponse
    }
}
