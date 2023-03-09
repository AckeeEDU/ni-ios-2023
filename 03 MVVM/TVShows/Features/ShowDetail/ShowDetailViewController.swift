import UIKit
import SwiftUI

final class ShowDetailViewController: UIViewController {
    private let viewModel: ShowDetailViewModel

    init(viewModel: ShowDetailViewModel) {
        self.viewModel = viewModel

        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func loadView() {
        super.loadView()

        let rootView = ShowDetailView(viewModel: self.viewModel)
        let vc = UIHostingController(rootView: rootView)
        embedController(vc)
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        navigationItem.title = viewModel.show.title
    }
}
