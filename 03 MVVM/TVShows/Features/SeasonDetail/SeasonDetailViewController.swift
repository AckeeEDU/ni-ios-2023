import UIKit
import SwiftUI

final class SeasonDetailViewController: UIViewController {
    private let viewModel: SeasonDetailViewModel

    init(viewModel: SeasonDetailViewModel) {
        self.viewModel = viewModel

        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func loadView() {
        super.loadView()

        let rootView = SeasonDetailView(viewModel: self.viewModel)
        let vc = UIHostingController(rootView: rootView)
        embedController(vc)
    }
}
