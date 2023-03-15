import SwiftUI

struct SearchView: View {
    @ObservedObject var viewModel: SearchViewModel
    let flowDelegate: SearchFlowDelegate?

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
            .padding(.horizontal)

            if viewModel.shows.isEmpty {
                Text("No shows to be found")
            } else {
                List(viewModel.shows) { show in
                    Button(show.show.title) {
                        flowDelegate?.showShow(show.show)
                    }
                }
            }

            Spacer()
        }
        .edgesIgnoringSafeArea(.bottom)
    }
}
