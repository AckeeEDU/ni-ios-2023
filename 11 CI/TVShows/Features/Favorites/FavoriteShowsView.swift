import SwiftUI

struct FavoriteShowsView<ViewModel: FavoriteShowsViewModeling>: View {
    @ObservedObject var viewModel: ViewModel
    let flowDelegate: FavoriteShowsFlowDelegate?

    var body: some View {
        Group {
            if viewModel.shows.isEmpty {
                Text("No favorite shows")
            } else {
                List(viewModel.shows) { show in
                    Button(show.show.title) {
                        flowDelegate?.showShow(show.show)
                    }
                }
            }
        }
        .isLoading($viewModel.isLoading) {
            await viewModel.fetchShows()
        }
        .task {
            await viewModel.fetchShows()
        }
    }
}
