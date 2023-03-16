import SwiftUI

protocol ProfileViewModeling: ObservableObject {
    func logout()
}

final class ProfileViewModel: ProfileViewModeling {
    func logout() {
        LoginManager.shared.logout()
    }
}
