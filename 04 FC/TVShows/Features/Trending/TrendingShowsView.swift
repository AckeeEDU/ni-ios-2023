import SwiftUI

struct TrendingShowsView: View {
    @ObservedObject var viewModel: TrendingShowsViewModel
    let flowDelegate: TrendingShowsFlowDelegate?

    var body: some View {
        List {
            ForEach(viewModel.shows) { show in
                Button(show.show.title) {
                    flowDelegate?.showShow(show.show)
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
