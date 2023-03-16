import UIKit
import SwiftUI
import ACKategories_iOS

protocol TrendingShowsFlowDelegate: AnyObject {
    func showSearch(from viewController: UIViewController)
    func showShow(_ show: Show)
}

final class TrendingShowsViewController<ViewModel: TrendingShowsViewModeling>: Base.ViewController {
    private let viewModel: ViewModel
    weak var flowDelegate: TrendingShowsFlowDelegate?

    // MARK: - Initialization

    init(
        viewModel: ViewModel,
        flowDelegate: TrendingShowsFlowDelegate?
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

        let rootView = TrendingShowsView(viewModel: self.viewModel, flowDelegate: flowDelegate)
        let vc = UIHostingController(rootView: rootView)
        embedController(vc)
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        navigationController?.navigationBar.prefersLargeTitles = true
        navigationItem.title = "Trending TV Shows"
        navigationItem.largeTitleDisplayMode = .automatic
        navigationItem.rightBarButtonItem = UIBarButtonItem(
            image: UIImage(systemName: "magnifyingglass"),
            style: .plain,
            target: self,
            action: #selector(searchTapped)
        )
    }

    @objc
    private func searchTapped() {
        flowDelegate?.showSearch(from: self)
    }
}
