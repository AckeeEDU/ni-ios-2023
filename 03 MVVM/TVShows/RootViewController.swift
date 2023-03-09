import UIKit

final class RootViewController: UIViewController {
    private weak var loginController: LoginViewController!
    private weak var tabBar: UITabBarController!

    override func loadView() {
        super.loadView()

        view.backgroundColor = .white

        let loginController = LoginViewController()
        embedController(loginController)
        self.loginController = loginController

        let trendingController = TrendingShowsViewController()
        let trendingNavigationController = UINavigationController(rootViewController: trendingController)
        trendingNavigationController.tabBarItem.title = "Trending"
        trendingNavigationController.tabBarItem.image = UIImage(systemName: "flame")

        let favoritesController = FavoriteShowsViewController()
        let favoritesNavigationController = UINavigationController(rootViewController: favoritesController)
        favoritesNavigationController.tabBarItem.title = "Favorites"
        favoritesNavigationController.tabBarItem.image = UIImage(systemName: "star")

        let profileController = ProfileViewController()
        let profileNavigationController = UINavigationController(rootViewController: profileController)
        profileNavigationController.tabBarItem.title = "Profile"
        profileNavigationController.tabBarItem.image = UIImage(systemName: "person")

        let tabBarController = UITabBarController()
        tabBarController.viewControllers = [
            trendingNavigationController,
            favoritesNavigationController,
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
