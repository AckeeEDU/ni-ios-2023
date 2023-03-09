import Foundation

struct Season: Codable {
    let number: Int
    let title: String
    let overview: String?
    let episodeCount: Int
}

extension Season: Identifiable {
    var id: Int { number }
}
