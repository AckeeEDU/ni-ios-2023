import UIKit
import SwiftUI
import ACKategories_iOS

protocol FavoriteShowsFlowDelegate: AnyObject {
    func showShow(_ show: Show)
}

final class FavoriteShowsViewController: Base.ViewController {
    private let viewModel = FavoriteShowsViewModel()
    weak var flowDelegate: FavoriteShowsFlowDelegate?

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
