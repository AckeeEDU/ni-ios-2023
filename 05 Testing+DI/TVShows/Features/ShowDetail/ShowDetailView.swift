import SwiftUI

struct ShowDetailView<ViewModel: ShowDetailViewModeling>: View {
    @ObservedObject var viewModel: ViewModel
    weak var flowDelegate: ShowDetailFlowDelegate?

    var body: some View {
        List(viewModel.seasons) { season in
            Button(season.title) {
                flowDelegate?.showSeasonDetail(season: season, show: viewModel.show)
            }
        }
        .isLoading($viewModel.isLoading) {
            await viewModel.fetchSeasons()
        }
    }
}
