//: [Previous](@previous)
//: # Swift Concurrency
//: ## Merge

import AsyncAlgorithms
import Foundation

let numbers = createAsyncStream(values: [10, 20, 30])
let numbers2 = createAsyncStream(values: [15, 25, 35, 45], delay: 0.7)

//: [Next](@next)

