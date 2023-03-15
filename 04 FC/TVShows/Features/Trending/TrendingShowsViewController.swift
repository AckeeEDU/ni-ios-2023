import UIKit
import SwiftUI

protocol TrendingShowsFlowDelegate: AnyObject {
    func showSearch(from viewController: UIViewController)
    func showShow(_ show: Show)
}

final class TrendingShowsViewController: UIViewController {
    private let viewModel = TrendingShowsViewModel()
    weak var flowDelegate: TrendingShowsFlowDelegate?

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
