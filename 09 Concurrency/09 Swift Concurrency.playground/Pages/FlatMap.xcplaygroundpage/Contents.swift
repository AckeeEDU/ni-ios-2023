//: [Previous](@previous)
//: # Swift Concurrency
//: ## FlatMap

import PlaygroundSupport

PlaygroundPage.current.needsIndefiniteExecution = true

let numbers = createAsyncStream(values: [10, 20, 30]).map { $0 + 5 }

let flatMapped = numbers.flatMap { number in
    createAsyncStream(values: ["1-" + String(number)])
}

Task {
    for await value in flatMapped {
        print(value)
    }
}


//: [Next](@next)

