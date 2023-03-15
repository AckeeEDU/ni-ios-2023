import Foundation

struct TrendingShow: Codable {
    let show: Show
}

extension TrendingShow: Identifiable {
    var id: Int { show.id }
}
