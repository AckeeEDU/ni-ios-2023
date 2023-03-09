import UIKit
import SwiftUI

final class FavoriteShowsViewController: UIViewController {
    private let viewModel = FavoriteShowsViewModel()

    override func loadView() {
        super.loadView()

        let rootView = FavoriteShowsView(
            viewModel: self.viewModel,
            onShowTapped: { [weak self] show in
                self?.onShowTapped(show)
            }
        )
        let vc = UIHostingController(rootView: rootView)
        embedController(vc)
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        navigationItem.title = "Favorites"
    }

    private func onShowTapped(_ show: Show) {
        let vc = ShowDetailViewController(
            viewModel: ShowDetailViewModel(
                show: show
            )
        )
        navigationController?.pushViewController(vc, animated: true)
    }
}
