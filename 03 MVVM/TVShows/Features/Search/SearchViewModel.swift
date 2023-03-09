import SwiftUI

final class SearchViewModel: ObservableObject {
    @Published var shows: [SearchedShow] = []

    var searchText = ""
    private var searchTask: Task<Void, Error>?

    func searchTextChanged(_ text: String) {
        searchText = text
        searchTask?.cancel()
        searchTask = Task {
            try await Task.sleep(for: .seconds(0.3))
            await self.fetchShows(query: text)
        }
    }

    @MainActor
    private func fetchShows(query: String) async {
        do {
            shows = try await TraktAPI.shared.searchShows(query: query)
        } catch {
            // Skip if the status of the task is cancelled (-999)
            guard (error as NSError).code != -999 else { return }
            print("[ERROR]", error.localizedDescription)
        }
    }
}
