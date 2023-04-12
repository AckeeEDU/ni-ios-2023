//: [Previous](@previous)
//: # Publishers
//: ## Just
//: - single value
//: - vhodný pro testy, pro případy kdy je potřeba vrátit "nějakou" value
import Combine

let just = Just(1)

just.sink { value in
    print(value)
}
//: [Next](@next)
