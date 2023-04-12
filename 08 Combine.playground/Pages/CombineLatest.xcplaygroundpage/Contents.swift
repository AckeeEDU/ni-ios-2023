//: [Previous](@previous)
//: # Operators
//: ## Merge
//: - http://neilpa.me/rac-marbles/#combineLatest
//: - podobně jako `map` spojuje dva a více streamů do jednoho
//: - dává poslední hodnotu ze všech kombinovaných streamů, při změně kteréhokoliv z nich
//: - jakmile nastane v jednom streamu error, skončí i zmergovaný stream
//: - merged stream skončí, když skončí všechny "child" streamy
import Combine

final class LoginVM: ObservableObject {
    @Published var username = ""
    @Published var password = ""
    @Published var hasCredentials = false

    private var cancellables = Set<AnyCancellable>()

    init() {
        $username.combineLatest($password)
            .map { username, password in
                print("[COMBINE] username:", username, "password:", password)
                return !username.isEmpty && !password.isEmpty
            }
            .sink { hasCredentials in
                self.hasCredentials = hasCredentials
            }
            .store(in: &cancellables)
//            .assign(to: &$hasCredentials)
    }
}

let loginVM = LoginVM()
loginVM.$hasCredentials.logEvents()

loginVM.username = "olejnjak"
loginVM.password = "password"
//: [Next](@next)
