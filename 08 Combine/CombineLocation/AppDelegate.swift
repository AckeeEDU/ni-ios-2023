import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        window = .init(frame: UIScreen.main.bounds)
        window?.rootViewController = ViewController(locationManager: CombineLocationManager())
        window?.makeKeyAndVisible()
        return true
    }
}

