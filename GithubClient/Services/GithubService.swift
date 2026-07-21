import Foundation
import Alamofire

class GithubService {
    static let shared = GithubService()
    private let baseUrl = AppConfig.apiBaseURL
    
    private init() {}

    private var headers: HTTPHeaders {
        [
            "Authorization": "Bearer \(AppConfig.apiToken)"
        ]
    }

    func getRepositories() async throws -> [Repsoitory] {
        return try await AF.request(
            "\(baseUrl)/user/repos",
            method: .get,
            parameters: [
                "sort": "created",
                "direction": "desc",
                "per_page": 100,
                "affiliation": "owner"
            ],
            headers: headers
        )
        .validate(statusCode: 200..<300)
        .serializingDecodable([Repsoitory].self)
        .value
    }
    func createRepository(name: String, desc: String) async throws -> Repsoitory {

        let response = await AF.request(
            "\(baseUrl)/user/repos",
            method: .post,
            parameters: [
                "name": name,
                "description": desc,
            ],
            encoding: JSONEncoding.default,
            headers: headers
            
        )
        .validate()
        .serializingDecodable(Repsoitory.self)
        .response

        if let data = response.data,
           let json = String(data: data, encoding: .utf8) {
            print("Response Body:")
            print(json)
        }

        switch response.result {
        case .success(let repo):
            return repo

        case .failure(let error):
            print("=== Alamofire Error ===")
            print(error)
            throw error
        }
    }
}

