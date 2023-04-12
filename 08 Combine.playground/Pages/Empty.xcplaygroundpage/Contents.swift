//: [Previous](@previous)
//: # Publishers
//: ## Empty
//: - single completion
//: - nebo taky no completion
//: - vhodný pro testy, pro případy kdy je potřeba vrátit "nějakou" value
import Combine

let empty = Empty<Int, CustomError>()
let never = Empty<Int, CustomError>(completeImmediately: false)

empty.sink { completion in
    print(completion)
} receiveValue: { value in
    print(value)
}

//: [Next](@next)
