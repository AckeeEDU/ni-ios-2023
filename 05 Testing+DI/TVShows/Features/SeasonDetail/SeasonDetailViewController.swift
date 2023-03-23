import UIKit
import SwiftUI
import ACKategories_iOS

final class SeasonDetailViewController<ViewModel: SeasonDetailViewModeling>: Base.ViewController {
    private let viewModel: ViewModel

    // MARK: - Initialization

    init(viewModel: ViewModel) {
        self.viewModel = viewModel

        super.init()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Lifecycle

    override func loadView() {
        super.loadView()

        let rootView = SeasonDetailView(viewModel: self.viewModel)
        let vc = UIHostingController(rootView: rootView)
        embedController(vc)
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        navigationItem.title = viewModel.title
    }
}
