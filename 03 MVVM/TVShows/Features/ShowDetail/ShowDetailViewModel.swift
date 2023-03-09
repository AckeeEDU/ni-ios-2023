import SwiftUI

final class ShowDetailViewModel: ObservableObject {
    let show: Show

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
