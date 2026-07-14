//
//  RepoListViewController.swift
//  GithubClient
//
//  Created by Usuario invitado on 14/7/26.
//

import Foundation

@MainActor
class RepoListViewController: ObservableObject {
    @Published var repositories: [Repsoitory] = []
    @Published var isLoading: Bool = false
    @Published var errorMsg: String?
    
    private let githubService: GithubService
    
    init(service: GithubService = .shared) {
        self.githubService = service
    }
    
    func loadRepositories() async {
        isLoading = true
        errorMsg = nil
        
        defer {
            isLoading = false
        }
        
        do {
            repositories = try await githubService.getRepositories()
        } catch {
            errorMsg = error.localizedDescription
        }
    }
}
