//: [Previous](@previous)
//: # Swift Concurrency
//: ## Map + Filter
//: - funguje stejně jako v Combine
import PlaygroundSupport

PlaygroundPage.current.needsIndefiniteExecution = true

protocol Service {
    func createNumbers() -> AsyncStream<Int>
}

final class S: Service {
    func createNumbers() -> AsyncStream<Int> {
        createAsyncStream(values: [10, 20, 30])
            .map { $0 + 5 }
            .eraseToAsyncStream()
    }
}

//let numbers = createAsyncStream(values: [10, 20, 30])
//    .map { $0 + 5 }

let service = S()

Task {
    let stream = service.createNumbers()
    
    for try await value in stream {
        print(value)
    }
}
//
//let even = createAsyncStream(values: Array(1...20)).filter { $0 % 2 == 0 }
//
//Task {
//    for await value in even {
//        print(value)
//    }
//}

//: [Next](@next)

