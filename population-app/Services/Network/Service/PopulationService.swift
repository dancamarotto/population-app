import Foundation

protocol PopulationServiceProtocol {
    func fetchNation() async throws -> NationDTO
    func fetchStates(year: String) async throws -> StateDTO
}

final class PopulationService: PopulationServiceProtocol {
    private let baseURL = "https://datausa.io"
    private let endpoint = "/api/data"
    private let network: NetworkManagerProtocol
    
    init(network: some NetworkManagerProtocol = NetworkManager()) {
        self.network = network
    }
    
    private func getURLComponents() throws -> URLComponents {
        guard var components = URLComponents(string: baseURL) else {
            throw PopulationServiceError.failedToCreateURLComponents
        }
        components.path = endpoint
        return components
    }
    
    private func buildRequest(
        drilldowns: String,
        measures: String = "Population",
        year: String? = "latest"
    ) throws -> URLRequest {
        var components = try getURLComponents()
        
        components.queryItems = [
            URLQueryItem(name: "drilldowns", value: drilldowns),
            URLQueryItem(name: "measures", value: measures),
            URLQueryItem(name: "year", value: year)
        ]
        
        guard let url = components.url else {
            throw PopulationServiceError.failedToCreateURLComponents
        }
        return URLRequest(url: url)
    }
}

// MARK: - Nation

extension PopulationService {
    func fetchNation() async throws -> NationDTO {
        let request = try buildRequest(drilldowns: "Nation", year: nil)
        return try await network.performRequest(request)
    }
}

// MARK: - States

extension PopulationService {
    func fetchStates(year: String) async throws -> StateDTO {
        let request = try buildRequest(drilldowns: "State", year: year)
        return try await network.performRequest(request)
    }
}

enum PopulationServiceError: Error {
    case failedToCreateURL
    case failedToCreateURLComponents
}
