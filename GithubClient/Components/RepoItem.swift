//
//  RepoItem.swift
//  GithubClient
//
//  Created by Usuario invitado on 7/7/26.
//

import SwiftUI
struct RepoItem : View {
    var body : some View {
        HStack{
            Image (uiImage: .githubLogo)
                .resizable()
                .frame(width:80 , height:80)
            VStack (alignment : .leading){
                Text("Nombre del repositorio")
                    .font(.title2)
                Text("Lorem Impus dolor")
                HStack{
                    Text("Lenguaje")
                        .font(.caption)
                    Spacer()
                    Text("Swift")
                        .font(.caption)
                }
            }
        }
        .padding()
    }
        
}
#Preview {
    RepoItem()
}
