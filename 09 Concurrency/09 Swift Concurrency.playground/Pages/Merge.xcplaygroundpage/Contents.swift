//: [Previous](@previous)
//: # Swift Concurrency
//: ## Merge

import AsyncAlgorithms
import Foundation
import PlaygroundSupport

PlaygroundPage.current.needsIndefiniteExecution = true

let numbers = createAsyncStream(values: [10, 20, 30])
let numbers2 = createAsyncStream(values: [15, 25, 35, 45], delay: 0.7)

Task {
    for await value in merge(numbers, numbers2) {
        print(Date(), value)
    }
}

//: [Next](@next)

