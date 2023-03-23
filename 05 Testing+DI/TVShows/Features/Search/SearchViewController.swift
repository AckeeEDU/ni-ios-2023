import UIKit
import SwiftUI
import ACKategories_iOS

protocol SearchFlowDelegate: AnyObject {
    func showShow(_ show: Show)
}

final class SearchViewController<ViewModel: SearchViewModeling>: Base.ViewController {
    private let viewModel: ViewModel
    weak var flowDelegate: SearchFlowDelegate?

    // MARK: - Initialization

    init(
        viewModel: ViewModel,
        flowDelegate: SearchFlowDelegate?
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

        let rootView = SearchView(viewModel: self.viewModel, flowDelegate: flowDelegate)
        let vc = UIHostingController(rootView: rootView)
        embedController(vc)
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        navigationItem.title = "Search"
    }
}
