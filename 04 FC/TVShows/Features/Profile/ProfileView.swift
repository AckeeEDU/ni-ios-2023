import SwiftUI

struct ProfileView<ViewModel: ProfileViewModeling>: View {
    @ObservedObject var viewModel: ViewModel

    var body: some View {
        Button("Log out") {
            viewModel.logout()
        }
    }
}
