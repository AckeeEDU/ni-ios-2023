import SwiftUI

final class ProfileViewModel: ObservableObject {
    func logout() {
        LoginManager.shared.logout()
    }
}
