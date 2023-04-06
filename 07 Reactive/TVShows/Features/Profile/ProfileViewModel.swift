import SwiftUI

protocol ProfileViewModeling: ObservableObject {
    var profile: Profile? { get }
    var isLoading: Bool { get set }
    var age: String? { get }
    var joined: String? { get }
    
    func logout()
    func fetchProfile(name: String) async
}

final class ProfileViewModel: ProfileViewModeling {
    typealias Dependencies = HasTraktAPIService
    
    // MARK: - Internal properties
    
    @Published var profile: Profile? = nil
    @Published var isLoading: Bool = true
    
    var age: String? {
        guard let profile = profile else { return nil }
        let age = String(profile.age)
        
        return [age, "years"].joined(separator: " ")
    }
    
    var joined: String? {
        guard
            let profile = profile,
            let date = DateFormatters.isoFormatter.date(from: profile.joinedAt)
        else { return nil }
        
        return DateFormatters.joinedFormatter.string(from: date)
    }
    
    let traktAPIService: TraktAPIServicing
    
    // MARK: - Initializers
    
    init(dependencies: Dependencies) {
        traktAPIService = dependencies.traktAPIService
    }
    
    // MARK: - Interface
    
    func logout() {
        LoginManager.shared.logout()
    }
    
    @MainActor
    func fetchProfile(name: String) async {
        do {
            profile = try await traktAPIService.profile(name: name)
        } catch {
            guard (error as NSError).code != -999 else { return }
            print("[ERROR]", error.localizedDescription)
        }
    }
}
