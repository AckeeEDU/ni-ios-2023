//: [Previous](@previous)
//: # Swift Concurrency
//: ## Map + Filter
//: - funguje stejně jako v Combine

let numbers = createAsyncStream(values: [10, 20, 30]).map { $0 + 5 }

//: [Next](@next)

