//: [Previous](@previous)
//: # Swift Concurrency
//: ## CombineLatest

import AsyncAlgorithms
import Foundation

let numbers = createAsyncStream(values: [10, 20, 30])
let strings = createAsyncStream(values: ["a", "b", "c", "d"], delay: 0.7)

//: [Next](@next)

