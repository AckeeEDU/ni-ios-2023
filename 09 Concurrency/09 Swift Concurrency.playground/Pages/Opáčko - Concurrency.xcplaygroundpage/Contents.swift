//: [Previous](@previous)
//: # Async opáčko
//: ## Swift Concurrency

import Foundation
import PlaygroundSupport

PlaygroundPage.current.needsIndefiniteExecution = true

Task {
    do {
        let (feedData, _) = try await URLSession.shared.data(from: .feed)
        let feed = try JSONDecoder.shared.decode([Post].self, from: feedData)
        
        print("Feed:", feed.count)
        
        if let firstPost = feed.first {
            let (commentsData, _) = try await URLSession.shared.data(from: .comments(post: firstPost.id))
            let comments = try JSONDecoder.shared.decode([Comment].self, from: commentsData)
            print("Comments:", comments.count)
        }
    } catch {
        print("Error:", error)
    }
}

//: [Next](@next)
