import Combine
import Foundation

final class LoginViewModel: ObservableObject {
    var loginURL: URL {
        var components = URLComponents(string: "https://trakt.tv/oauth/authorize")
        components?.queryItems = [
            URLQueryItem(name: "response_type", value: "code"),
            URLQueryItem(name: "client_id", value: "c97c817dedfab758e2d31af2323566f9872b8acfa438120466d09e4c7cb0c3ac"),
            URLQueryItem(name: "redirect_uri", value: "movies://login")
        ]

        return components!.url!
    }
}
