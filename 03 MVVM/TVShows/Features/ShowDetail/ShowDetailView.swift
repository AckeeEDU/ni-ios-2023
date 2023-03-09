import SwiftUI

struct ShowDetailView: View {
    @ObservedObject var viewModel: ShowDetailViewModel

    var body: some View {
        List(viewModel.seasons) { season in
            NavigationLink(
                destination: SeasonDetailView(
                    viewModel: SeasonDetailViewModel(season: season, show: viewModel.show)
                )
            ) {
                Text(season.title)
            }
        }
        .isLoading($viewModel.isLoading) {
            await viewModel.fetchSeasons()
        }
        .navigationTitle(viewModel.show.title)
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                Button {
                    viewModel.toggleFavorites()
                } label: {
                    Image(systemName: viewModel.isFavorite ? "star.fill" : "star")
                }
            }
        }
        .onAppear {
            viewModel.checkFavorites()
        }
    }
}
