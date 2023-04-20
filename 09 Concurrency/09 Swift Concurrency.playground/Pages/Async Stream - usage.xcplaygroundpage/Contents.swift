//: [Previous](@previous)

import CoreLocation
import Foundation
import PlaygroundSupport

PlaygroundPage.current.needsIndefiniteExecution = true

let locations = AsyncStream<CLLocation> { continuation in
    Task {
        let locationValues = [
            CLLocation(latitude: 0, longitude: 0),
            CLLocation(latitude: 10, longitude: 10),
            CLLocation(latitude: 20, longitude: 20),
            CLLocation(latitude: 30, longitude: 30),
        ]
        
        locationValues.forEach { location in
            continuation.yield(location)
            Thread.sleep(forTimeInterval: 1)
        }
        continuation.finish()
    }
}

Task {
    for await location in locations {
        print(Date(), location.coordinate)
    }
}

//: [Next](@next)
