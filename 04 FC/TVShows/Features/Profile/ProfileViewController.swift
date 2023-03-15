import UIKit
import SwiftUI
import ACKategories_iOS

final class ProfileViewController: Base.ViewController {
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
