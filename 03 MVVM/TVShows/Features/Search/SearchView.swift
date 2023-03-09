import SwiftUI

struct SearchView: View {
    @ObservedObject var viewModel: SearchViewModel

    var body: some View {
        VStack {
            TextField(
                "Search",
                text: Binding(
                    get: { viewModel.searchText },
                    set: { text in
                        viewModel.searchTextChanged(text)
                    }
                )
            )

            if viewModel.shows.isEmpty {
                Text("No shows to be found")
            } else {
                List(viewModel.shows) { show in
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
            }
        }
    }
}
