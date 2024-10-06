@testable import population_app

final class PopulationServiceMock: PopulationServiceProtocol {
    
    var shouldFetchNationThrow: Bool = false
    var returnedNationDTO: NationDTO!
    
    var shouldFetchStatesThrow: Bool = false
    var returnedStateDTO: StateDTO!
    
    func fetchNation() async throws -> NationDTO {
        if shouldFetchNationThrow {
            throw MockError(message: "fetchNation error")
        }
        return returnedNationDTO
    }
    
    func fetchStates(year: String) async throws -> StateDTO {
        if shouldFetchStatesThrow {
            throw MockError(message: "fetchStates error")
        }
        return returnedStateDTO
    }
}
