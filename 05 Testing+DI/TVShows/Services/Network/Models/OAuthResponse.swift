import Foundation

struct OAuthResponse: Codable {
    let accessToken: String
    let refreshToken: String
}
