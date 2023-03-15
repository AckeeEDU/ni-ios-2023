import Foundation

struct Episode: Codable {
    let number: Int
    let season: Int
    let ids: IDs
    let title: String
    let overview: String?
    let runtime: Int
    let rating: Double
}

extension Episode: Identifiable, Equatable {
    var id: Int { number }
}
