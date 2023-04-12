//: [Previous](@previous)
//: # Publishers
//: ## PassthroughSubject
//: - pipe s value a errorem
//: - _z jedný strany tam ládujete eventy a na druhý straně je někdo třeba čte_
//: - drtivou většinu use cases tim umlátíte
import Combine

let subject = PassthroughSubject<Int, Error>()

subject.sink { completion in
    print(completion)
} receiveValue: { value in
    print(value)
}

//subject.send(12)
//subject.send(100)
//: [Next](@next)
