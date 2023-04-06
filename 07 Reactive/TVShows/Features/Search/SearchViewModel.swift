import SwiftUI
import Combine

protocol SearchViewModeling: ObservableObject {
    var shows: [SearchedShow] { get }
    var searchText: String { get set }
}

final class SearchViewModel: SearchViewModeling {
    typealias Dependencies = HasTraktAPIService
    
    @Published var searchText = ""
    @Published var shows: [SearchedShow] = []

    private var searchTask: Task<Void, Error>?
    
    let traktAPIService: TraktAPIServicing
    
    init(dependencies: Dependencies) {
        traktAPIService = dependencies.traktAPIService

        setupBindings()
    }

    private var cancellables = Set<AnyCancellable>()

    private func setupBindings() {
        NotificationCenter.default
            .publisher(for: UIApplication.didBecomeActiveNotification)
            .sink { _ in
                print("active")
            }
            .store(in: &cancellables)

        $searchText
            .handleEvents(receiveOutput: { [weak self] _ in
                self?.searchTask?.cancel()
            })
            .debounce(for: 0.3, scheduler: DispatchQueue.main)
            .sink { [weak self] value in
                self?.searchTask = Task { [weak self] in
                    await self?.fetchShows(query: value)
                }
            }
            .store(in: &cancellables)
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
