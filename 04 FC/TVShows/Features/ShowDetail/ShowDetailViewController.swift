import UIKit
import SwiftUI
import ACKategories_iOS

protocol ShowDetailFlowDelegate: AnyObject {
    func showSeasonDetail(season: Season, show: Show)
}

final class ShowDetailViewController: Base.ViewController {
    private let viewModel: ShowDetailViewModel
    weak var flowDelegate: ShowDetailFlowDelegate?

    init(viewModel: ShowDetailViewModel) {
        self.viewModel = viewModel

        super.init()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func loadView() {
        super.loadView()

        let rootView = ShowDetailView(viewModel: self.viewModel, flowDelegate: flowDelegate)
        let vc = UIHostingController(rootView: rootView)
        embedController(vc)
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        navigationItem.title = viewModel.show.title
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        viewModel.checkFavorites()
        setFavoriteItem()
    }

    // MARK: - Private helpers

    private func setFavoriteItem() {
        navigationItem.rightBarButtonItem = UIBarButtonItem(
            image: UIImage(systemName: viewModel.isFavorite ? "star.fill" : "star"),
            style: .plain,
            target: self,
            action: #selector(favoriteTapped)
        )
    }

    // MARK: - Actions

    @objc
    private func favoriteTapped() {
        viewModel.toggleFavorites()
        setFavoriteItem()
    }
}
