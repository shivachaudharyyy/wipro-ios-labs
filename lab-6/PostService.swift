
import Foundation

enum APIError: LocalizedError {
    case invalidURL
    case invalidResponse
    case serverError(Int)
    case decodingFailed
    case emptyResults
    case networkError(String)

    var errorDescription: String? {
        switch self {
        case .invalidURL:
            return "The API URL is not valid."
        case .invalidResponse:
            return "Something went wrong with the server response."
        case .serverError(let code):
            return "Server returned status code \(code)."
        case .decodingFailed:
            return "Unable to read the data from the server."
        case .emptyResults:
            return "No posts were found."
        case .networkError(let message):
            return "Network error: \(message)"
        }
    }
}

class PostService {

    func fetchPosts() async throws -> [Post] {

        var components = URLComponents()
        components.scheme = "https"
        components.host = "jsonplaceholder.typicode.com"
        components.path = "/posts"

        guard let url = components.url else {
            throw APIError.invalidURL
        }

        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.timeoutInterval = 20

        do {
            let (data, response) = try await URLSession.shared.data(for: request)

            guard let httpResponse = response as? HTTPURLResponse else {
                throw APIError.invalidResponse
            }

            guard (200...299).contains(httpResponse.statusCode) else {
                throw APIError.serverError(httpResponse.statusCode)
            }

            let decoder = JSONDecoder()
            let posts = try decoder.decode([Post].self, from: data)

            guard !posts.isEmpty else {
                throw APIError.emptyResults
            }

            return posts

        } catch let error as APIError {
            throw error

        } catch is DecodingError {
            throw APIError.decodingFailed

        } catch {
            throw APIError.networkError(error.localizedDescription)
        }
    }
}
