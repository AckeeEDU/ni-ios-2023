import SwiftUI

struct ProfileView<ViewModel: ProfileViewModeling>: View {
    @ObservedObject var viewModel: ViewModel

    var body: some View {
        List {
            ProfileItemView(
                imageName: "person.crop.circle",
                text: viewModel.profile?.name
            )
            
            ProfileItemView(
                imageName: "waveform.path.ecg.rectangle",
                text: viewModel.age
            )
            
            ProfileItemView(
                imageName: "location.circle",
                text: viewModel.profile?.location
            )
            
            ProfileItemView(
                imageName: "calendar.badge.clock",
                text: viewModel.joined
            )
            
            Button {
                viewModel.logout()
            } label: {
                HStack(spacing: 4) {
                    Image(systemName: "rectangle.portrait.and.arrow.right")
                    
                    Text("Log out")
                        .fontWeight(.medium)
                }
            }
            .foregroundColor(.red)
        }
        .isLoading($viewModel.isLoading) {
            await viewModel.fetchProfile(name: "igor.rosocha")
        }
    }
}

// MARK: - Previews

struct ProfileView_Previews: PreviewProvider {
    static var previews: some View {
        ProfileView(
            viewModel: ProfileViewModel(
                dependencies: appDependencies
            )
        )
    }
}
