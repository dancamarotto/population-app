import Foundation

protocol NetworkManagerProtocol {
    func performRequest<T: Decodable>(_ request: URLRequest) async throws -> T
}

class NetworkManager {
    private let urlSession: URLSessionProtocol
    
    init(urlSession: some URLSessionProtocol = URLSession.shared) {
        self.urlSession = urlSession
    }
}

extension NetworkManager: NetworkManagerProtocol {
    func performRequest<T: Decodable>(_ request: URLRequest) async throws -> T {
        let (data, _) = try await urlSession.data(for: request)
        let decoded = try JSONDecoder().decode(T.self, from: data)
        return decoded
    }
}
