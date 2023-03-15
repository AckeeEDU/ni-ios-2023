import SwiftUI

final class SeasonDetailViewModel: ObservableObject {
    let season: Season
    let show: Show

    @Published var isLoading = true
    @Published var episodes: [Episode] = []

    init(season: Season, show: Show) {
        self.season = season
        self.show = show
    }

    func isLastEpisode(_ episode: Episode) -> Bool {
        episode == episodes.last
    }

    @MainActor
    func fetchEpisodes() async {
        episodes = try! await TraktAPI.shared.episodesForSeason(season, show: show)
    }
}
