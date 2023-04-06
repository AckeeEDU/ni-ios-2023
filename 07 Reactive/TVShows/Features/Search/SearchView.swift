import SwiftUI

struct SearchView<ViewModel: SearchViewModeling>: View {
    @ObservedObject var viewModel: ViewModel
    let flowDelegate: SearchFlowDelegate?

    var body: some View {
        VStack {
            TextField(
                "Search",
                text: $viewModel.searchText
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
