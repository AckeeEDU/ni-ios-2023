import SwiftUI

struct SeasonDetailView<ViewModel: SeasonDetailViewModeling>: View {
    @ObservedObject var viewModel: ViewModel

    var body: some View {
        ScrollView {
            VStack(alignment: .leading) {
                ForEach(viewModel.episodes) { episode in
                    VStack(alignment: .leading, spacing: 8) {
                        Text(episode.title)
                            .bold()

                        if let overview = episode.overview {
                            Text(overview)
                        }

                        if !viewModel.isLastEpisode(episode) {
                            Divider()
                        }
                    }
                }
            }
            .padding()
        }
        .isLoading($viewModel.isLoading) {
            await viewModel.fetchEpisodes()
        }
    }
}
