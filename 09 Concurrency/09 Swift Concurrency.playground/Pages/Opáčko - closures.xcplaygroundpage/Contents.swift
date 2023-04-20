//: [Previous](@previous)
//: # Async opáčko
//: ## Closures

import Foundation
import PlaygroundSupport

PlaygroundPage.current.needsIndefiniteExecution = true

URLSession.shared.dataTask(with: .feed) { data, response, error in
    do {
        if let error {
            throw error
        }
        
        guard let data else {
            print("No data received")
            return
        }
        
        let feed = try JSONDecoder.shared.decode([Post].self, from: data)
        
        print("Feed:", feed.count)
        
        if let firstPost = feed.first {
            URLSession.shared.dataTask(with: .comments(post: firstPost.id)) { data, response, error in
                do {
                    if let error {
                        throw error
                    }
                    
                    guard let data else {
                        print("No data received")
                        return
                    }
                    
                    let comments = try JSONDecoder.shared.decode([Comment].self, from: data)
                    print("Comments:", comments.count)
                } catch {
                    print("Error:", error)
                }
            }
            .resume()
        }
    } catch {
        print("Error:", error)
    }
}.resume()

//: [Next](@next)
