//: [Previous](@previous)
//: # Publishers
//: ## Future
//: - single value or error
//: - typicky vhodný např. pro networking
import Combine
import Foundation
import PlaygroundSupport

PlaygroundPage.current.needsIndefiniteExecution = true

var cancellables = Set<AnyCancellable>()
let future = Future<Int, Error> { promise in
    print("doing something")
    DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
        promise(.failure(CustomError()))
    }
}

future.logEvents()
//.store(in: &cancellables)
//: [Next](@next)
