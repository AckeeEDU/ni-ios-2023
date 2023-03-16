import SwiftUI

struct LoginView<ViewModel: LoginViewModeling>: View {
    @ObservedObject var viewModel: ViewModel

    var body: some View {
        Link("Login", destination: viewModel.loginURL)
    }
}
