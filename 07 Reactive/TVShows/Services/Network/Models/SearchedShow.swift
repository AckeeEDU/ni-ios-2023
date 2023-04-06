import Foundation

struct SearchedShow: Codable {
    let show: Show
}

extension SearchedShow: Identifiable {
    var id: Int { show.id }
}
