//: [Previous](@previous)
//: # Async opáčko
//: ## Swift Concurrency - Continuation

import Foundation
import PlaygroundSupport

PlaygroundPage.current.needsIndefiniteExecution = true

extension URLSession {
    func ourCustomData(from url: URL) async throws -> (Data, URLResponse) {
        try await withUnsafeThrowingContinuation { continuation in
            dataTask(with: url) { data, response, error in
                if let data, let response {
                    continuation.resume(returning: (data, response))
                } else if let error {
                    continuation.resume(throwing: error)
                } else {
                    fatalError("Data&Response or Error expected")
                }
            }
            .resume()
        }
    }
}

Task {
    do {
        let (feedData, _) = try await URLSession.shared.ourCustomData(from: .feed)
        let feed = try JSONDecoder.shared.decode([Post].self, from: feedData)
        
        print("Feed:", feed.count)
        
        if let firstPost = feed.first {
            let (commentsData, _) = try await URLSession.shared.ourCustomData(from: .comments(post: firstPost.id))
            let comments = try JSONDecoder.shared.decode([Comment].self, from: commentsData)
            print("Comments:", comments.count)
        }
    } catch {
        print("Error:", error)
    }
}

//: [Next](@next)
