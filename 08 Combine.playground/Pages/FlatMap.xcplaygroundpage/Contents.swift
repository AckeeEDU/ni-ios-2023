//: [Previous](@previous)
//: # Operators
//: ## Map
//: - bere vstup a transformuje ho na jiného publishera
//: - užitečné pro sekvenci network requestů
import Combine
import Foundation
import PlaygroundSupport

PlaygroundPage.current.needsIndefiniteExecution = true

struct Post: Decodable {
    let id: String
}

struct Comment: Decodable {
    let text: String
}

var cancellables = Set<AnyCancellable>()
let feed = URLSession.shared.dataTaskPublisher(for: .init(string: "https://fitstagram.ackee.cz/api/feed")!)
    .map(\.data)
    .decode(type: [Post].self, decoder: JSONDecoder())

feed.compactMap { $0.first?.id }
    .flatMap(maxPublishers: .max(1)) { id in
        URLSession.shared.dataTaskPublisher(for: .init(string: "https://fitstagram.ackee.cz/api/feed/" + id + "/comments")!)
            .map(\.data)
            .decode(type: [Comment].self, decoder: JSONDecoder())
    }
    .logEvents()
    .store(in: &cancellables)

//: [Next](@next)
