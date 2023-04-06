import SwiftUI

protocol SeasonDetailViewModeling: ObservableObject {
    var isLoading: Bool { get set }
    var episodes: [Episode] { get }
    var title: String { get }

    func isLastEpisode(_ episode: Episode) -> Bool
    func fetchEpisodes() async
}

final class SeasonDetailViewModel: SeasonDetailViewModeling {
    typealias Dependencies = HasTraktAPIService
    let season: Season
    let show: Show

    var title: String {
        "Season \(season.number)"
    }

    @Published var isLoading = true
    @Published var episodes: [Episode] = []
    
    let traktAPIService: TraktAPIServicing

    init(dependencies: Dependencies, season: Season, show: Show) {
        self.traktAPIService = dependencies.traktAPIService
        self.season = season
        self.show = show
    }

    func isLastEpisode(_ episode: Episode) -> Bool {
        episode == episodes.last
    }

    @MainActor
    func fetchEpisodes() async {
        episodes = try! await traktAPIService.episodesForSeason(season, show: show)
    }
}
