import UIKit
import ACKategories_iOS

final class ShowDetailFlowCoordinator: Base.FlowCoordinatorNoDeepLink {
    func start(show: Show, withNavigationController navVC: UINavigationController) {
        super.start(with: navVC)

        let vc = ShowDetailViewController(viewModel: ShowDetailViewModel(show: show))
        vc.flowDelegate = self
        navVC.pushViewController(vc, animated: true)

        navigationController = navVC
        rootViewController = vc
    }
}

extension ShowDetailFlowCoordinator: ShowDetailFlowDelegate {
    func showSeasonDetail(season: Season, show: Show) {
        let vc = SeasonDetailViewController(viewModel: SeasonDetailViewModel(season: season, show: show))
        navigationController?.pushViewController(vc, animated: true)
    }
}
