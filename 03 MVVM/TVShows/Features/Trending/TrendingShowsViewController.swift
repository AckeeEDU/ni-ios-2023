import UIKit
import SwiftUI

final class TrendingShowsViewController: UIViewController {
    private let viewModel = TrendingShowsViewModel()

    override func loadView() {
        super.loadView()

        let rootView = TrendingShowsView(viewModel: self.viewModel)
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
        let vc = SearchViewController()
        let navVC = UINavigationController(rootViewController: vc)
        present(navVC, animated: true)
    }
}
