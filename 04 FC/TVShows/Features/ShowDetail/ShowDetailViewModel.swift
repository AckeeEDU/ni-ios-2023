import SwiftUI

protocol ShowDetailViewModeling: ObservableObject {
    var isLoading: Bool { get set }
    var isFavorite: Bool { get }
    var seasons: [Season] { get }
    var title: String { get }
    var show: Show { get }

    func fetchSeasons() async
    func toggleFavorites()
    func checkFavorites()
}

final class ShowDetailViewModel: ShowDetailViewModeling {
    let show: Show
    var title: String { show.title }

    @Published var isLoading = true
    @Published var isFavorite = false
    @Published var seasons: [Season] = []

    init(show: Show) {
        self.show = show
    }

    @MainActor
    func fetchSeasons() async {
        seasons = try! await TraktAPI.shared.seasonsForShow(show)
    }

    func toggleFavorites() {
        var shows = UserDefaults.standard.value(forKey: "shows") as? [Int] ?? []
        if shows.contains(show.id) {
            shows.removeAll { $0 == show.id }
        } else {
            shows.append(show.id)
        }
        UserDefaults.standard.setValue(shows, forKey: "shows")
        checkFavorites()
    }

    func checkFavorites() {
        let shows = UserDefaults.standard.value(forKey: "shows") as? [Int] ?? []
        isFavorite = shows.contains(show.id)
    }
}
