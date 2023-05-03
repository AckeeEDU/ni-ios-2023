import UIKit
import ACKategories_iOS

final class SearchFlowCoordinator: Base.FlowCoordinatorNoDeepLink {
    override func start(from viewController: UIViewController) {
        super.start(from: viewController)

        let vm = SearchViewModel(dependencies: appDependencies)
        let vc = SearchViewController(viewModel: vm, flowDelegate: self)
        let navVC = UINavigationController(rootViewController: vc)

        self.navigationController = navVC
        self.rootViewController = navVC

        viewController.present(navVC, animated: true)
    }
}

extension SearchFlowCoordinator: SearchFlowDelegate {
    func showShow(_ show: Show) {
        guard let navigationController else { return }
        let showCoordinator = ShowDetailFlowCoordinator(show: show)
        addChild(showCoordinator)
        showCoordinator.start(with: navigationController)
    }
}
