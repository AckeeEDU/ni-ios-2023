import UIKit
import ACKategories_iOS

final class RootViewController: Base.ViewController {
    private weak var loginController: LoginViewController!
    private weak var tabBar: UITabBarController!

    var trendingCoordinator: TrendingShowsFlowCoordinator!
    var favoritesCoordinator: FavoriteShowsFlowCoordinator!

    override func loadView() {
        super.loadView()

        view.backgroundColor = .white

        let loginController = LoginViewController()
        embedController(loginController)
        self.loginController = loginController

        trendingCoordinator = TrendingShowsFlowCoordinator()
        let trendingController = trendingCoordinator.start()
        trendingController.tabBarItem.title = "Trending"
        trendingController.tabBarItem.image = UIImage(systemName: "flame")

        favoritesCoordinator = FavoriteShowsFlowCoordinator()
        let favoritesController = favoritesCoordinator.start()
        favoritesController.tabBarItem.title = "Favorites"
        favoritesController.tabBarItem.image = UIImage(systemName: "star")

        let profileController = ProfileViewController()
        let profileNavigationController = UINavigationController(rootViewController: profileController)
        profileNavigationController.tabBarItem.title = "Profile"
        profileNavigationController.tabBarItem.image = UIImage(systemName: "person")

        let tabBarController = UITabBarController()
        tabBarController.viewControllers = [
            trendingController,
            favoritesController,
            profileNavigationController
        ]
        embedController(tabBarController)
        self.tabBar = tabBarController
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        LoginManager.shared.delegate = self

        updateState()
    }

    private func updateState() {
        if UserDefaults.standard.string(forKey: "accessToken") != nil {
            loginController.view.isHidden = true
            tabBar.view.isHidden = false
        } else {
            loginController.view.isHidden = false
            tabBar.view.isHidden = true
        }
    }
}

extension RootViewController: LoginManagerDelegate {
    func loggedInUpdated() {
        updateState()
    }
}
