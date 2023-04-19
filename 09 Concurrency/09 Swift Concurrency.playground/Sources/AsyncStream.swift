import Foundation

public func createAsyncStream<Value>(values: [Value], delay: TimeInterval = 1) -> AsyncStream<Value> {
    .init { continuation in
        Task {
            for value in values {
                continuation.yield(value)
                try await Task.sleep(for: .seconds(.init(delay)))
            }
            continuation.finish()
        }
    }
}
