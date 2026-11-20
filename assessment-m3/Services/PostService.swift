
import Foundation

enum PostError: LocalizedError {

    case invalidURL
    case invalidResponse
    case serverError(Int)
    case decodingError

    var errorDescription: String? {

        switch self {

        case .invalidURL:
            return "The API URL is not valid."

        case .invalidResponse:
            return "Unable to get a valid response from the server."

        case .serverError(let code):
            return "Server returned an error. Status code: \(code)"

        case .decodingError:
            return "Unable to read the data received from the server."
        }
    }
}

class PostService {

    private let apiURL = "https://jsonplaceholder.typicode.com/posts"

    func fetchPosts() async throws -> [Post] {

        guard let url = URL(string: apiURL) else {
            throw PostError.invalidURL
        }

        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.timeoutInterval = 20

        let (data, response) = try await URLSession.shared.data(
            for: request
        )

        guard let httpResponse = response as? HTTPURLResponse else {
            throw PostError.invalidResponse
        }

        guard (200...299).contains(httpResponse.statusCode) else {
            throw PostError.serverError(httpResponse.statusCode)
        }

        do {

            let decoder = JSONDecoder()

            let posts = try decoder.decode(
                [Post].self,
                from: data
            )

            return posts

        } catch {

            throw PostError.decodingError
        }
    }
}
