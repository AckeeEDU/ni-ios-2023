import Combine

public extension Publisher {
    func logEvents(file: StaticString = #file, line: UInt = #line, function: StaticString = #function) -> Cancellable {
        let prefix = [
            String(describing: file).replacingOccurrences(of: ".xcplaygroundpage", with: ""),
            String(line)
        ].joined(separator: ":")
        
        return sink { completion in
            Swift.print(prefix, "[COMPLETION]", completion)
        } receiveValue: { value in
            Swift.print(prefix, "[VALUE]", value)
        }
    }
}
