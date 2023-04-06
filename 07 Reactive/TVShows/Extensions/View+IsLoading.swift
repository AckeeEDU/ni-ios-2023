import SwiftUI

extension View {
    func isLoading(_ isLoading: Binding<Bool>, task: @escaping () async -> Void) -> some View {
        ZStack {
            if isLoading.wrappedValue {
                ProgressView()
                    .task {
                        await task()
                        DispatchQueue.main.async {
                            isLoading.wrappedValue = false
                        }
                    }
            } else {
                self
            }
        }
    }
}
