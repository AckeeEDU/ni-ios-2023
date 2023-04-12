//: [Previous](@previous)
//: # Operators
//: ## Filter
//: - http://neilpa.me/rac-marbles/#filter
//: - jen ořezává vstup
//: - nemění signaturu publishera
//: - nemůže vyfailovat - má failovatelnou variantu `tryFilter`
import Combine

let p1 = Just("NI-IOS")

let mapped = p1.filter { $0.hasPrefix("NI") }
    .map { $0.count % 2 }
    .map { $0 % 2 }

let mapped2 = p1.filter { $0.hasPrefix("BI") }

//: [Next](@next)
