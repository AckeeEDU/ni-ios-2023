//
//  ProfileViewModelTests.swift
//  TVShowsTests
//
//  Created by Igor Rosocha on 22.03.2023.
//

import XCTest

@testable import TVShows

final class ProfileViewModelTests: XCTestCase {
    private struct Dependencies: ProfileViewModel.Dependencies {
        var traktAPIService: TraktAPIServicing
    }
    
    private var traktAPIService: TraktAPIServiceMock!
    private var dependencies: Dependencies!

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        traktAPIService = TraktAPIServiceMock.init()
        dependencies = .init(traktAPIService: traktAPIService)
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    // MARK: - Unit tests

    func testProfileFetch() async {
        let profileVM = ProfileViewModel(dependencies: dependencies)
        
        XCTAssertNil(profileVM.profile)
        
        await profileVM.fetchProfile(name: "igor.rosocha")
        
        XCTAssertNotNil(profileVM.profile)
    }
    
    func testProfileHasCorrectValues() async {
        let profileVM = ProfileViewModel(dependencies: dependencies)
        let profileMock: Profile = .mock
        
        await profileVM.fetchProfile(name: "igor.rosocha")
        
        XCTAssertEqual(profileVM.profile, profileMock)
    }
    
    // MARK: - Snapshot tests
    
    func testProfileSnapshot() {
        let profileVM = ProfileViewModel(dependencies: dependencies)
        profileVM.profile = .mock
        profileVM.isLoading = false
        
        let view = ProfileView(viewModel: profileVM)
        
        AssertSnapshot(view)
    }
}
