import SwiftUI

struct ProfileView: View {
    @ObservedObject var viewModel: ProfileViewModel

    var body: some View {
        Button("Log out") {
            viewModel.logout()
        }
    }
}
