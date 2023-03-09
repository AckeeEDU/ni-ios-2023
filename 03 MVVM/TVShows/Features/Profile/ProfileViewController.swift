import UIKit
import SwiftUI

final class ProfileViewController: UIViewController {
    private let viewModel = ProfileViewModel()

    override func loadView() {
        super.loadView()

        let rootView = ProfileView(viewModel: self.viewModel)
        let vc = UIHostingController(rootView: rootView)
        embedController(vc)
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        navigationItem.title = "Profile"
    }
}
