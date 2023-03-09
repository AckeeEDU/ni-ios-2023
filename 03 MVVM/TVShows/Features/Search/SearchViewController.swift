import UIKit
import SwiftUI

final class SearchViewController: UIViewController {
    private let viewModel = SearchViewModel()

    override func loadView() {
        super.loadView()

        let rootView = SearchView(viewModel: self.viewModel)
        let vc = UIHostingController(rootView: rootView)
        embedController(vc)
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        navigationItem.title = "Search"
    }
}
