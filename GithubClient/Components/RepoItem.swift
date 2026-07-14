import SwiftUI

struct RepoItem: View {
    let repository: Repsoitory
    
    var body: some View {
        HStack {
            AsyncImage(url: URL(string: repository.owner.avatarUrl)) { image in
                image
                    .resizable()
                    .scaledToFill()
            } placeholder: {
                Image(.githubLogo)
                    .resizable()
                    .scaledToFill()
            }
            .frame(width: 80, height: 80)
            .clipShape(Circle())
            
            Spacer()
            
            VStack(alignment: .leading) {
                Text(repository.name)
                    .font(.title2)
                
                Text(repository.description)
                    .font(.caption)
                
                HStack {
                    Text("Lenguaje:")
                        .font(.caption)
                    Spacer()
                    Text(repository.language)
                        .font(.caption)
                }
            }
        }
        .padding()
    }
}

#Preview {
    RepoItem(
        repository: Repsoitory(
            id: 1,
            name: "Repositorio de prueba",
            description: "Lorem Ipsum es simplemente el texto de relleno de las imprentas y archivos de texto.",
            language: "Swift",
            owner: UserInfo(
                login: "SCabreraML",
                name: "Sebastián Cabrera",
                avatarUrl: "https://avatars.githubusercontent.com/u/191403505?v=4",
                bio: "Esta es una Bio de prueba"
            )
        )
    )
}
