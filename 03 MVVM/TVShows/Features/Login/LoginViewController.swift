import UIKit
import SwiftUI

final class LoginViewController: UIViewController {
    private let viewModel = LoginViewModel()
    
    override func loadView() {
        super.loadView()

        let rootView = LoginView(viewModel: self.viewModel)
        let vc = UIHostingController(rootView: rootView)
        embedController(vc)
    }
}
