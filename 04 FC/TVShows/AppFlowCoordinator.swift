import UIKit
import ACKategories_iOS

final class AppFlowCoordinator: Base.FlowCoordinatorNoDeepLink {
    private weak var window: UIWindow?

    override func start(in window: UIWindow) {
        self.window = window

        super.start(in: window)

        prepareWindow()

        LoginManager.shared.delegate = self
    }

    private func prepareWindow() {
        if LoginManager.shared.isLoggedIn {
            showMain()
        } else {
            stop()
            showLogin()
        }
    }

    private func showMain() {
        let trendingCoordinator = TrendingShowsFlowCoordinator()
        addChild(trendingCoordinator)
        let trendingController = trendingCoordinator.start()
        trendingController.tabBarItem.title = "Trending"
        trendingController.tabBarItem.image = UIImage(systemName: "flame")
        trendingController.tabBarItem.selectedImage = UIImage(systemName: "flame.fill")

        let favoritesCoordinator = FavoriteShowsFlowCoordinator()
        addChild(favoritesCoordinator)
        let favoritesController = favoritesCoordinator.start()
        favoritesController.tabBarItem.title = "Favorites"
        favoritesController.tabBarItem.image = UIImage(systemName: "star")
        favoritesController.tabBarItem.selectedImage = UIImage(systemName: "star.fill")

        let profileController = ProfileViewController()
        let profileNavigationController = UINavigationController(rootViewController: profileController)
        profileNavigationController.tabBarItem.title = "Profile"
        profileNavigationController.tabBarItem.image = UIImage(systemName: "person")
        profileNavigationController.tabBarItem.selectedImage = UIImage(systemName: "person.fill")

        let tabBarController = UITabBarController()
        tabBarController.viewControllers = [
            trendingController,
            favoritesController,
            profileNavigationController
        ]

        rootViewController = tabBarController

        window?.rootViewController = tabBarController
        window?.makeKeyAndVisible()
    }

    private func showLogin() {
        let loginController = LoginViewController()
        rootViewController = loginController

        window?.rootViewController = loginController
        window?.makeKeyAndVisible()
    }
}

extension AppFlowCoordinator: LoginManagerDelegate {
    func loggedInUpdated() {
        prepareWindow()
    }
}
