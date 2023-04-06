import Foundation

struct InvalidURL: Error { }
struct ShowDoesntExist: Error {
    let id: Int
}

protocol HasTraktAPIService {
    var traktAPIService: TraktAPIServicing { get }
}

protocol TraktAPIServicing {
    func token(code: String) async throws -> OAuthResponse
    func trendingShows(page: Int) async throws -> [TrendingShow]
    func seasonsForShow(_ show: Show) async throws -> [Season]
    func episodesForSeason(_ season: Season, show: Show) async throws -> [Episode]
    func episode(id: Int, season: Season, show: Show) async throws -> Episode
    func searchShows(query: String) async throws -> [SearchedShow]
    func shows(ids: [Int]) async throws -> [SearchedShow]
    func show(id: Int) async throws -> SearchedShow
    func profile(name: String) async throws -> Profile
}

final class TraktAPIService: TraktAPIServicing {
    func token(code: String) async throws -> OAuthResponse {
        let url = URL(string: "https://api.trakt.tv/oauth/token")!
        var request = URLRequest(url: url)
        request.httpMethod = "POST"

        let headers = request.allHTTPHeaderFields ?? [:]
        request.allHTTPHeaderFields = headers.merging(["Content-Type": "application/json"], uniquingKeysWith: { $1 })
        let body = [
            "code": code,
            "client_id": "c97c817dedfab758e2d31af2323566f9872b8acfa438120466d09e4c7cb0c3ac",
            "client_secret": "9eb5191557cd0205c42851b83ba75c4b5f2a2b29cd4b547fe6e90c0e1f1a4b63",
            "grant_type": "authorization_code",
            "redirect_uri": "movies://login",
        ]
        request.httpBody = try JSONSerialization.data(withJSONObject: body)

        let (data, _) = try await URLSession.shared.data(for: request)

        return try JSONDecoder.app.decode(OAuthResponse.self, from: data)
    }

    func trendingShows(page: Int = 1) async throws -> [TrendingShow] {
        let query = page > 1 ? [URLQueryItem(name: "page", value: String(page))] : []
        return try await makeRequest(path: "shows/trending", query: query)
    }

    func seasonsForShow(_ show: Show) async throws -> [Season] {
        try await makeRequest(path: "shows/\(show.id)/seasons?extended=full")
    }

    func episodesForSeason(_ season: Season, show: Show) async throws -> [Episode] {
        try await withThrowingTaskGroup(of: Episode.self) { group in
            // Prepare array for the responses
            var episodes: [Episode] = []

            // Reserve capacity since we know the total number of episodes
            episodes.reserveCapacity(season.episodeCount)

            // For each episode append new task to the task group
            for episodeNumber in 1...season.episodeCount {
                group.addTask {
                    try await self.episode(id: episodeNumber, season: season, show: show)
                }
            }

            // Wait for all episodes to by downloaded
            // and then append each one to the array
            for try await episode in group {
                episodes.append(episode)
            }

            return episodes.sorted { $0.number < $1.number }
        }
    }

    func episode(id: Int, season: Season, show: Show) async throws -> Episode {
        try await makeRequest(path: "shows/\(show.id)/seasons/\(season.id)/episodes/\(id)?extended=full")
    }

    func searchShows(query: String) async throws -> [SearchedShow] {
        let queryItems: [URLQueryItem] = [
            .init(name: "query", value: query),
            .init(name: "extended", value: "full")
        ]
        return try await makeRequest(path: "search/show", query: queryItems)
    }

    func shows(ids: [Int]) async throws -> [SearchedShow] {
        try await withThrowingTaskGroup(of: SearchedShow.self) { group in
            var shows: [SearchedShow] = []
            shows.reserveCapacity(ids.count)

            for id in ids {
                group.addTask {
                    try await self.show(id: id)
                }
            }

            for try await show in group {
                shows.append(show)
            }

            return shows.sorted {
                let lhs = ids.firstIndex(of: $0.id) ?? ids.count
                let rhs = ids.firstIndex(of: $1.id) ?? ids.count
                return lhs < rhs
            }
        }
    }

    func show(id: Int) async throws -> SearchedShow {
        let shows: [SearchedShow] = try await makeRequest(path: "search/trakt/\(id)?type=show")
        if let show = shows.first {
            return show
        } else {
            throw ShowDoesntExist(id: id)
        }
    }
    
    func profile(name: String) async throws -> Profile {
        try await makeRequest(path: "users/\(name)?extended=full")
    }

    // MARK: - Private helpers

    private func updateToken() async {
        let url = URL(string: "https://api.trakt.tv/oauth/token")!

        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        let headers = request.allHTTPHeaderFields ?? [:]
        request.allHTTPHeaderFields = headers.merging(["Content-Type": "application/json"], uniquingKeysWith: { $1 })
        let body = [
            "refresh_token": UserDefaults.standard.string(forKey: "refreshToken") ?? "",
            "client_id": "c97c817dedfab758e2d31af2323566f9872b8acfa438120466d09e4c7cb0c3ac",
            "client_secret": "9eb5191557cd0205c42851b83ba75c4b5f2a2b29cd4b547fe6e90c0e1f1a4b63",
            "grant_type": "refresh_token"
        ]

        request.httpBody = try! JSONSerialization.data(withJSONObject: body)

        let (data, _) = try! await dataRequest(for: request)

        let response = try! JSONDecoder.app.decode(OAuthResponse.self, from: data)

        UserDefaults.standard.set(response.accessToken, forKey: "accessToken")
        UserDefaults.standard.set(response.refreshToken, forKey: "refreshToken")
    }

    private func makeRequest<Response: Decodable>(
        path: String,
        query: [URLQueryItem] = [],
        response: Response.Type = Response.self
    ) async throws -> Response {
        var components = URLComponents(
            url: URL(string: "https://api.trakt.tv/\(path)")!,
            resolvingAgainstBaseURL: false
        )
        if !query.isEmpty {
            components?.queryItems = query
        }

        guard let url = components?.url else { throw InvalidURL() }

        var request = URLRequest(url: url)

        let headers = request.allHTTPHeaderFields ?? [:]
        let accessToken = UserDefaults.standard.string(forKey: "accessToken") ?? ""
        request.allHTTPHeaderFields = headers.merging([
            "Authorization": "Bearer \(accessToken)",
            "Content-Type": "application/json",
            "trakt-api-version": "2",
            "trakt-api-key": "c97c817dedfab758e2d31af2323566f9872b8acfa438120466d09e4c7cb0c3ac"
        ], uniquingKeysWith: { $1 })

        var (data, response) = try await dataRequest(for: request)

        if (response as? HTTPURLResponse)?.statusCode == 403 {
            await updateToken()

            let accessToken = UserDefaults.standard.string(forKey: "accessToken") ?? ""
            request.allHTTPHeaderFields = headers.merging(["Authorization": "Bearer \(accessToken)"], uniquingKeysWith: { $1 })

            (data, response) = try! await dataRequest(for: request)
        }

        return try JSONDecoder.app.decode(Response.self, from: data)
    }

    private func dataRequest(for request: URLRequest) async throws -> (Data, URLResponse) {
        print("⬆️", request.url!.absoluteString)
        if let body = request.httpBody {
            print("BODY:", String(data: body, encoding: .utf8)!)
        }
        let (data, response) = try await URLSession.shared.data(for: request)
        print("⬇️", request.url!.absoluteString, "[", (response as? HTTPURLResponse)?.statusCode ?? 0, "]")
        print(String(data: data, encoding: .utf8)!)

        return (data, response)
    }
}

extension JSONDecoder {
    static let app: JSONDecoder = {
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        return decoder
    }()
}


func api() {
    URLSession.shared
        .dataTaskPublisher(for: URL(string: "https://seznam.cz")!)
        .map { $0.data }
//    Publisher<Output, Failure>
    //    Publisher2<Output2, Failure2>
        .decode(type: Show.self, decoder: JSONDecoder.app)
        .sink { show in

        }
        .store()
}
