//: [Previous](@previous)
//: # Publishers
//: ## Deferred
//: - wrapper nad jakýmkoliv publisherem
//: - má stejnou signaturu jako wrapped publisher
//: - koncept hot and cold producera
//: - oddaluje práci do bodu, kdy má nějakého subscribera
import Combine
import Foundation
import PlaygroundSupport

PlaygroundPage.current.needsIndefiniteExecution = true

var cancellables = Set<AnyCancellable>()

let future = Future<Int, Error> { promise in
    print("doing something")
    DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
        promise(.success(1))
    }
}

let deferred = Deferred {
    Future<Int, Error> { promise in
        print("doing something in deferred")
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            promise(.failure(CustomError()))
            promise(.success(1))
        }
    }
}

deferred.logEvents().store(in: &cancellables)


//future.sink { completion in
//    print(completion)
//} receiveValue: { value in
//    print(value)
//}.store(in: &cancellables)
//: [Next](@next)
