import SwiftUI

protocol TrendingShowsViewModeling: ObservableObject {
    var isLoading: Bool { get set }
    var shows: [TrendingShow] { get }

    func fetchFirstPage() async
    func fetchNextPage() async
}

final class TrendingShowsViewModel: TrendingShowsViewModeling {
    typealias Dependencies = HasTraktAPIService
    
    @Published var isLoading = true
    @Published var shows: [TrendingShow] = []

    private var page = 1
    
    let traktAPIService: TraktAPIServicing
    
    init(dependencies: Dependencies) {
        traktAPIService = dependencies.traktAPIService
    }

    @MainActor
    func fetchFirstPage() async {
        page = 1
        shows = try! await traktAPIService.trendingShows(page: page)
    }

    @MainActor
    func fetchNextPage() async {
        page += 1
        let shows = try! await traktAPIService.trendingShows(page: page)
        self.shows += shows
    }
}
