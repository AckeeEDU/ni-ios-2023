//: [Previous](@previous)
//: # Publishers
//: ## CurrentValueSubject
//: - pipe s value a errorem **a ještě navíc si drží aktuální/poslední hodnotu**
//: - _z jedný strany tam ládujete eventy a na druhý straně je někdo třeba čte_
//: - drtivou většinu use cases tim umlátíte
import Combine

let subject = CurrentValueSubject<Int, Error>(1)

subject.sink { _ in
    
} receiveValue: { value in
    print(value)
    print("Value", subject.value)
}

subject.value = 10
subject.send(12)
//: [Next](@next)
