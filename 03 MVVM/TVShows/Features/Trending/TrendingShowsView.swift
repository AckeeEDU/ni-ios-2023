import SwiftUI

struct TrendingShowsView: View {
    @ObservedObject var viewModel: TrendingShowsViewModel

    var body: some View {
        List {
            ForEach(viewModel.shows) { show in
                NavigationLink(
                    destination: ShowDetailView(
                        viewModel: ShowDetailViewModel(
                            show: show.show
                        )
                    )
                ) {
                    Text(show.show.title)
                }
            }

            ProgressView()
                .onAppear {
                    Task {
                        await viewModel.fetchNextPage()
                    }
                }
        }
        .isLoading($viewModel.isLoading) {
            await viewModel.fetchFirstPage()
        }
    }
}
