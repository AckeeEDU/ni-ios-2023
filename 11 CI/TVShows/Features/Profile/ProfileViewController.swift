import UIKit
import SwiftUI
import ACKategories_iOS

final class ProfileViewController<ViewModel: ProfileViewModeling>: Base.ViewController {
    private let viewModel: ViewModel

    // MARK: - Initialization

    init(viewModel: ViewModel) {
        self.viewModel = viewModel

        super.init()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Lifecycle

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
