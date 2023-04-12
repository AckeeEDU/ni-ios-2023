//: [Previous](@previous)
//: # Publishers+Operators
//: - publisherů je hrozně moc (omrkněte si např. namespace [`Publishers`](https://developer.apple.com/documentation/combine/publishers), jsou tam povětšinou operátory)
//: - každý operátor mění typ publishera - not nice, blbě se to používá v rozhraní
import Combine
import Foundation

struct OAuthResponse: Decodable {
    let token: String
}

protocol TraktAPIServicing {
    func token2(code: String) -> AnyPublisher<String, Error>
}

final class API: TraktAPIServicing {
    func token(code: String) -> any Publisher<String, Error> {
        let publisher = URLSession.shared.dataTaskPublisher(for: .init(string: "")!)
            .map(\.data)
            .decode(type: OAuthResponse.self, decoder: JSONDecoder())
            .map(\.token)
        return publisher
    }

    func token2(code: String) -> AnyPublisher<String, Error> {
        let publisher = URLSession.shared.dataTaskPublisher(for: .init(string: "")!)
            .map(\.data)
            .decode(type: OAuthResponse.self, decoder: JSONDecoder())
            .map(\.token)
        return publisher.eraseToAnyPublisher()
    }
}


//: [Next](@next)
