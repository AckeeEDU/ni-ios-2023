//: [Previous](@previous)
//: # Swift Concurrency
//: ## Concurrency + Combine

import Combine
import PlaygroundSupport

PlaygroundPage.current.needsIndefiniteExecution = true

let subject = PassthroughSubject<Int, Never>()

subject.sink { value in
    print("[sink]", value)
    
}

Task {
    for await value in subject.values {
        print("[for]", value)
    }
}

subject.send(10)
subject.send(20)

