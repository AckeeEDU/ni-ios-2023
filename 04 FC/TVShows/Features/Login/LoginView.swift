import SwiftUI

struct LoginView: View {
    @ObservedObject var viewModel: LoginViewModel

    var body: some View {
        Link("Login", destination: viewModel.loginURL)
    }
}
