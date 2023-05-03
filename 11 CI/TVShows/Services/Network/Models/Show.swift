import Foundation

struct Show: Codable {
    let title: String
    let year: Int?
    let ids: IDs
}

extension Show: Identifiable {
    var id: Int { ids.trakt }
}
