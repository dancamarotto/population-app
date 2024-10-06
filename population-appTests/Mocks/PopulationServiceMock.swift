@testable import population_app

final class PopulationServiceMock: PopulationServiceProtocol {
    
    private(set) var fetchNationCalled: Bool = false
    var shouldFetchNationThrow: Bool = false
    var returnedNationDTO: NationDTO!
    
    private(set) var fetchStatesCalled: Bool = false
    var shouldFetchStatesThrow: Bool = false
    var returnedStateDTO: StateDTO!
    
    func fetchNation() async throws -> NationDTO {
        fetchNationCalled = true
        if shouldFetchNationThrow {
            throw MockError(message: "fetchNation error")
        }
        return returnedNationDTO
    }
    
    func fetchStates(year: String) async throws -> StateDTO {
        fetchStatesCalled = true
        if shouldFetchStatesThrow {
            throw MockError(message: "fetchStates error")
        }
        return returnedStateDTO
    }
}
