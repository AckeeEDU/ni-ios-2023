//: [Previous](@previous)
//: # Operators
//: ## Map
//: - http://neilpa.me/rac-marbles/#map
//: - bere vstup a transformuje ho jinou hodnotu
//: - nemůže vyfailovat
import Combine

let p1 = Just("")

let mapped = p1.map { $0.count }
mapped.logEvents()

//: - má failovatelnou variantu `tryMap`
//: - mění typ erroru na `Error`

p1.tryMap { value in
    if value.count < 10 {
        throw CustomError()
    }
    return value.count
}
.logEvents()

//: [Next](@next)
