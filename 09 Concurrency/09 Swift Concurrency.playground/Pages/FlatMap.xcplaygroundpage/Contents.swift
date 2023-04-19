//: [Previous](@previous)
//: # Swift Concurrency
//: ## FlatMap

import PlaygroundSupport

PlaygroundPage.current.needsIndefiniteExecution = true

let numbers = createAsyncStream(values: [10, 20, 30]).map { $0 + 5 }

//: [Next](@next)

