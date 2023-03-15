import UIKit
import ACKategories_iOS

final class TrendingShowsFlowCoordinator: Base.FlowCoordinatorNoDeepLink {
    override func start() -> UIViewController {
        super.start()

        let vc = TrendingShowsViewController()
        vc.flowDelegate = self
        let navVC = UINavigationController(rootViewController: vc)

        rootViewController = vc
        navigationController = navVC

        return navVC
    }
}

extension TrendingShowsFlowCoordinator: TrendingShowsFlowDelegate {
    func showSearch(from viewController: UIViewController) {
        let searchCoordinator = SearchFlowCoordinator()
        addChild(searchCoordinator)
        searchCoordinator.start(from: viewController)
    }

    func showShow(_ show: Show) {
        guard let navigationController else { return }
        let showCoordinator = ShowDetailFlowCoordinator()
        addChild(showCoordinator)
        showCoordinator.start(show: show, withNavigationController: navigationController)
    }
}
