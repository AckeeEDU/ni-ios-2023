import UIKit
import ACKategories_iOS

final class ShowDetailFlowCoordinator: Base.FlowCoordinatorNoDeepLink {
    private let show: Show

    init(show: Show) {
        self.show = show
    }

    override func start(with navigationController: UINavigationController) {
        super.start(with: navigationController)

        let vm = ShowDetailViewModel(dependencies: appDependencies, show: show)
        let vc = ShowDetailViewController(viewModel: vm, flowDelegate: self)
        navigationController.pushViewController(vc, animated: true)

        rootViewController = vc
    }
}

extension ShowDetailFlowCoordinator: ShowDetailFlowDelegate {
    func showSeasonDetail(season: Season, show: Show) {
        let vc = SeasonDetailViewController(viewModel: SeasonDetailViewModel(dependencies: appDependencies, season: season, show: show))
        navigationController?.pushViewController(vc, animated: true)
    }
}
