//
//  RepoList.swift
//  GithubClient
//
//  Created by Usuario invitado on 14/7/26.
//

import SwiftUI

struct RepoList: View {
    
    @StateObject private var viewModel = RepoListViewController()

    var body: some View {
        NavigationStack {
            Group {
                if viewModel.isLoading && viewModel.repositories.isEmpty {
                   
                    ProgressView("Cargando repositorios...")
                } else if let error = viewModel.errorMsg {
                    
                    VStack(spacing: 16) {
                        Image(systemName: "exclamationmark.triangle")
                            .font(.largeTitle)
                            .foregroundColor(.red)
                        Text(error)
                            .multilineTextAlignment(.center)
                        Button("Reintentar") {
                            Task {
                                await viewModel.loadRepositories()
                            }
                        }
                        .buttonStyle(.borderedProminent)
                    }
                    .padding()
                } else {
                    
                    ScrollView {
                        LazyVStack(spacing: 12) {
                            ForEach(viewModel.repositories, id: \.id) { repo in
                                RepoItem(repository: repo)
                            }
                        }
                    }
                }
            }
            .navigationTitle("Repositorios")
            
            .task {
                await viewModel.loadRepositories()
            }
        }
    }
}

#Preview {
    RepoList()
}
