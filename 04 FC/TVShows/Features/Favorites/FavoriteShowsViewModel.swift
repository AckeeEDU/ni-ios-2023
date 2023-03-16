import SwiftUI

protocol FavoriteShowsViewModeling: ObservableObject {
    var isLoading: Bool { get set }
    var shows: [SearchedShow] { get }

    func fetchShows() async
}

final class FavoriteShowsViewModel: FavoriteShowsViewModeling {
    @Published var isLoading = true
    @Published var shows: [SearchedShow] = []

    var ids: [Int] {
        UserDefaults.standard.value(forKey: "shows") as? [Int] ?? []
    }

    @MainActor
    func fetchShows() async {
        guard !ids.isEmpty else { return }
        shows = try! await TraktAPI.shared.shows(ids: ids)
    }
}
