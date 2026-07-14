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
}

