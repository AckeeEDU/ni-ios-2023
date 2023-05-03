import SwiftUI

protocol SearchViewModeling: ObservableObject {
    var shows: [SearchedShow] { get }
    var searchText: String { get }

    func searchTextChanged(_ text: String)
}

final class SearchViewModel: SearchViewModeling {
    typealias Dependencies = HasTraktAPIService
    
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
    
    let traktAPIService: TraktAPIServicing
    
    init(dependencies: Dependencies) {
        traktAPIService = dependencies.traktAPIService
    }

    @MainActor
    private func fetchShows(query: String) async {
        do {
            shows = try await traktAPIService.searchShows(query: query)
        } catch {
            // Skip if the status of the task is cancelled (-999)
            guard (error as NSError).code != -999 else { return }
            print("[ERROR]", error.localizedDescription)
        }
    }
}
