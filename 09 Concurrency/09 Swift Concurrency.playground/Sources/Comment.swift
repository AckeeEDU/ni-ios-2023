import Foundation

public struct Comment: Decodable, CustomStringConvertible {
    public var description: String {
        """
        Comment {
            id: \(id)
            text: \(text)
        }
        """
    }
    
    
    public let id: String
    public let text: String
    
    public init(id: String, text: String) {
        self.id = id
        self.text = text
    }
}
