import UIKit
import SwiftUI
import ACKategories_iOS

final class SeasonDetailViewController: Base.ViewController {
    private let viewModel: SeasonDetailViewModel

    init(viewModel: SeasonDetailViewModel) {
        self.viewModel = viewModel

        super.init()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func loadView() {
        super.loadView()

        let rootView = SeasonDetailView(viewModel: self.viewModel)
        let vc = UIHostingController(rootView: rootView)
        embedController(vc)
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        navigationItem.title = "Season \(viewModel.season.number)"
    }
}
