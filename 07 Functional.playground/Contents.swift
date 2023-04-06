import Foundation

func evenNumbers(_ array: [Int]) -> [Int] {
    var newArray: [Int] = []
    for element in array {
        if element % 2 == 0 {
            newArray.append(element)
        }
    }
    return newArray
}

func stringNumbers(_ array: [Int]) -> [String] {
    var stringArray: [String] = []
    for element in array {
        stringArray.append(String(element))
    }
    return stringArray
}


let array = [1, 2, 3, 4, 5, 6, 7, 8, 9, 10]


let evenArray = evenNumbers(array)
print(evenArray)


let stringArray = stringNumbers(array)
print(stringArray)


let evenStringArray = stringNumbers(evenNumbers(array))
print(evenStringArray)


func _map<A, B>(_ closure: (A) -> B, values: [A]) -> [B] {
    var bs: [B] = []
    for element in values {
        let newElement = closure(element)
        bs.append(newElement)
    }
    return bs
}

func __map<A, B>(_ closure: @escaping (A) -> B) -> ([A]) -> [B] {
    return { values in
        var bs: [B] = []
        for element in values {
            let newElement = closure(element)
            bs.append(newElement)
        }
        return bs
    }
}

func stringNumbers2(_ array: [Int]) -> [String] {
    let mapper: ([Int]) -> [String] = __map(String.init)
    return mapper(array)
}

//stringNumbers2(array) == __map(String.init)(array)

////////////////////////////////////////////////////
///

print(array.map { value in String(value) })
print(array.filter { value in value % 2 == 0 })

let evenArray2 = array
    .filter { value in value % 2 == 0 }
    .flatMap { element in
        (0..<element).map { _ in element }
    }
    .map { value in String(value) }
print(evenArray2)
