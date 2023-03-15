import UIKit
import SwiftUI
import ACKategories_iOS

protocol SearchFlowDelegate: AnyObject {
    func showShow(_ show: Show)
}

final class SearchViewController: Base.ViewController {
    private let viewModel = SearchViewModel()
    weak var flowDelegate: SearchFlowDelegate?

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
