//: [Previous](@previous)
//: # Operators
//: ## Merge
//: - http://neilpa.me/rac-marbles/#merge
//: - mám dva nebo více publisherů a spojuji je do jednoho streamu
//: - nevíte, ze kterého streamu hodnota přišla
//: - protože to streamy spojuje, je potřeba aby všechny měly stejný `Output` a `Error`
//: - jakmile nastane v jednom streamu error, skončí i zmergovaný stream
//: - merged stream skončí, když skončí všechny "child" streamy
//: - useful např. pro tableView s pull to refreshem
import Combine

//let p1 = Just(1)
//let p2 = CurrentValueSubject<Int, Never>(2)
//
//p1.merge(with: p2).logEvents()
//
//p2.send(completion: .finished)

let initialData = (1...10).publisher.collect() // Just(1...10)
let refreshData = (100...110).publisher.collect()

var tableData = [Int]()

initialData.sink { tableData = $0 }

print("[TABLE]", tableData)

refreshData.sink { tableData = $0 }

print("[TABLE] refresh", tableData)

initialData.merge(with: refreshData)
    .logEvents()

print("[TABLE] refresh", tableData)
//: [Next](@next)
