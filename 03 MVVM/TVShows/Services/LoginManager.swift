import Foundation

protocol LoginManagerDelegate: NSObject {
    func loggedInUpdated()
}

final class LoginManager {
    static let shared = LoginManager()

    var isLoggedIn: Bool = false
    weak var delegate: LoginManagerDelegate?

    var accessToken: String? {
        get { UserDefaults.standard.string(forKey: "accessToken") }
        set { UserDefaults.standard.set(newValue, forKey: "accessToken") }
    }

    var refreshToken: String? {
        get { UserDefaults.standard.string(forKey: "refreshToken") }
        set { UserDefaults.standard.set(newValue, forKey: "refreshToken") }
    }

    private init() {
        updateLoggedInState()
    }

    func handleURL(_ url: URL) -> Bool {
        let components = URLComponents(url: url, resolvingAgainstBaseURL: false)
        guard let code = components?.queryItems?.first(where: { $0.name == "code" })?.value else { return false }

        Task {
            // Obtain an access token for the given code
            let response = try! await TraktAPI.shared.token(code: code)

            DispatchQueue.main.async { [weak self] in
                self?.login(response)
            }
        }

        return true
    }

    func login(_ response: OAuthResponse) {
        accessToken = response.accessToken
        refreshToken = response.refreshToken
        updateLoggedInState()
        delegate?.loggedInUpdated()
    }

    func logout() {
        accessToken = nil
        refreshToken = nil
        updateLoggedInState()
        delegate?.loggedInUpdated()
    }

    private func updateLoggedInState() {
        isLoggedIn = accessToken != nil
    }
}
