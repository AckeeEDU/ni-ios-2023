import UIKit
import ACKategories_iOS

final class FavoriteShowsFlowCoordinator: Base.FlowCoordinatorNoDeepLink {
    override func start() -> UIViewController {
        super.start()

        let vm = FavoriteShowsViewModel(dependencies: appDependencies)
        let vc = FavoriteShowsViewController(viewModel: vm, flowDelegate: self)
        let navVC = UINavigationController(rootViewController: vc)

        rootViewController = vc
        navigationController = navVC

        return navVC
    }
}

extension FavoriteShowsFlowCoordinator: FavoriteShowsFlowDelegate {
    func showShow(_ show: Show) {
        guard let navigationController else { return }
        let showCoordinator = ShowDetailFlowCoordinator(show: show)
        addChild(showCoordinator)
        showCoordinator.start(with: navigationController)
    }
}
