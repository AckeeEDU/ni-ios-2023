import SwiftUI

struct ShowDetailView: View {
    @ObservedObject var viewModel: ShowDetailViewModel
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
