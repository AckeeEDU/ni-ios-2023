import SwiftUI

struct FavoriteShowsView: View {
    @ObservedObject var viewModel: FavoriteShowsViewModel

    let onShowTapped: (Show) -> Void

    var body: some View {
        Group {
            if viewModel.shows.isEmpty {
                Text("No favorite shows")
            } else {
                List(viewModel.shows) { show in
                    Button {
                        onShowTapped(show.show)
                    } label: {
                        Text(show.show.title)
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
