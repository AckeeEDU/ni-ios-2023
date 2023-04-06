import UIKit
import SwiftUI
import ACKategories_iOS

protocol FavoriteShowsFlowDelegate: AnyObject {
    func showShow(_ show: Show)
}

final class FavoriteShowsViewController<ViewModel: FavoriteShowsViewModeling>: Base.ViewController {
    private let viewModel: ViewModel
    private weak var flowDelegate: FavoriteShowsFlowDelegate?

    // MARK: - Initialization

    init(
        viewModel: ViewModel,
        flowDelegate: FavoriteShowsFlowDelegate?
    ) {
        self.viewModel = viewModel
        self.flowDelegate = flowDelegate

        super.init()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Lifecycle

    override func loadView() {
        super.loadView()

        let rootView = FavoriteShowsView(viewModel: self.viewModel, flowDelegate: flowDelegate)
        let vc = UIHostingController(rootView: rootView)
        embedController(vc)
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        navigationItem.title = "Favorites"
    }
}
