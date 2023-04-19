import Foundation

public extension URL {
    static var feed: URL { .init(string: "https://fitstagram.ackee.cz/api/feed")! }
    
    static func comments(post id: String) -> URL {
        .init(string: "https://fitstagram.ackee.cz/api/feed/" + id + "/comments")!
    }
}
