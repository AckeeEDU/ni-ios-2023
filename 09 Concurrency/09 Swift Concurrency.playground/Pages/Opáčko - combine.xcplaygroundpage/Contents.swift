//: # Swift Concurrency + Async streams
//: ## Combine

import Combine
import Foundation
import PlaygroundSupport

PlaygroundPage.current.needsIndefiniteExecution = true

var cancellables = Set<AnyCancellable>()

URLSession.shared.dataTaskPublisher(for: .feed)
    .map(\.data)
    .decode(type: [Post].self, decoder: JSONDecoder.shared)
    .handleEvents(receiveOutput: { feed in
        print("Feed:", feed.count)
    })
    .flatMap(maxPublishers: .max(1)) { feed -> AnyPublisher<Data, Error> in
        guard let firstPost = feed.first else { return Empty(outputType: Data.self, failureType: Error.self).eraseToAnyPublisher() }
        return URLSession.shared.dataTaskPublisher(for: .comments(post: firstPost.id))
            .map(\.data)
            .mapError { $0 as Error }
            .eraseToAnyPublisher()
    }
    .decode(type: [Comment].self, decoder: JSONDecoder.shared)
    .sink { completion in
        switch completion {
        case .finished: break
        case .failure(let error):
            print("Error:", error)
        }
        
        PlaygroundPage.current.finishExecution()
    } receiveValue: { comments in
        print("Comments:", comments.count)
    }
    .store(in: &cancellables)

//: [Next](@next)
