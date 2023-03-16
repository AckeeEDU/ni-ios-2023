import UIKit
import ACKategories_iOS

final class ShowDetailFlowCoordinator: Base.FlowCoordinatorNoDeepLink {
    private let show: Show

    init(show: Show) {
        self.show = show
    }

    override func start(with navigationController: UINavigationController) {
        super.start(with: navigationController)

        let vc = ShowDetailViewController(viewModel: ShowDetailViewModel(show: show))
        vc.flowDelegate = self
        navigationController.pushViewController(vc, animated: true)

        rootViewController = vc
    }
}

extension ShowDetailFlowCoordinator: ShowDetailFlowDelegate {
    func showSeasonDetail(season: Season, show: Show) {
        let vc = SeasonDetailViewController(viewModel: SeasonDetailViewModel(season: season, show: show))
        navigationController?.pushViewController(vc, animated: true)
    }
}
