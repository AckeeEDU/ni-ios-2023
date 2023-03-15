import UIKit
import SwiftUI
import ACKategories_iOS

final class LoginViewController: Base.ViewController {
    private let viewModel = LoginViewModel()
    
    override func loadView() {
        super.loadView()

        let rootView = LoginView(viewModel: self.viewModel)
        let vc = UIHostingController(rootView: rootView)
        embedController(vc)
    }
}
