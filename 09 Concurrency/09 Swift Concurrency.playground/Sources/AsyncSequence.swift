import Foundation

public extension AsyncSequence {
    func eraseToAsyncStream() -> AsyncStream<Element> {
        .init { continuation in
            Task {
                for try await element in self {
                    continuation.yield(element)
                }
                continuation.finish()
            }
        }
    }
    
    func eraseToAsyncThrowingStream() -> AsyncThrowingStream<Element, Error> {
        .init { continuation in
            Task {
                do {
                    for try await element in self {
                        continuation.yield(element)
                    }
                    continuation.finish()
                } catch {
                    continuation.finish(throwing: error)
                }
            }
        }
    }
}
