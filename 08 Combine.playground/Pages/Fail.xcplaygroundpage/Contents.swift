//: [Previous](@previous)
//: # Publishers
//: ## Fail
//: - single error
//: - vhodný pro testy, pro případy kdy je potřeba vrátit "nějakej" error
import Combine

let fail = Fail<Int, CustomError>(error: .init())

fail.sink { completion in
    print(completion)
} receiveValue: { value in
    print(value)
}
//: [Next](@next)
