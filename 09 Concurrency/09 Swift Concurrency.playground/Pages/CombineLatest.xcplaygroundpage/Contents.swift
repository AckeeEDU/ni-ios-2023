//: [Previous](@previous)
//: # Swift Concurrency
//: ## CombineLatest

import AsyncAlgorithms
import Foundation
import PlaygroundSupport

PlaygroundPage.current.needsIndefiniteExecution = true

let numbers = createAsyncStream(values: [10, 20, 30])
let strings = createAsyncStream(values: ["a", "b", "c", "d"], delay: 0.7)

Task {
    for await (number, string) in combineLatest(numbers, strings) {
        print(Date(), number, string)
    }
}

//: [Next](@next)

