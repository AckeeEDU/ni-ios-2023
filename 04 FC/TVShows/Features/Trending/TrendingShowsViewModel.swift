import SwiftUI

final class TrendingShowsViewModel: ObservableObject {
    @Published var isLoading = true
    @Published var shows: [TrendingShow] = []

    private var page = 1

    @MainActor
    func fetchFirstPage() async {
        page = 1
        shows = try! await TraktAPI.shared.trendingShows()
    }

    @MainActor
    func fetchNextPage() async {
        page += 1
        let shows = try! await TraktAPI.shared.trendingShows(page: page)
        self.shows += shows
    }
}
