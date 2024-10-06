import XCTest
@testable import population_app

final class PopulationServiceTests: XCTestCase {
    var sut: PopulationService!
    var network: NetworkManagerMock!
    
    override func setUp() {
        super.setUp()
        network = NetworkManagerMock()
        sut = PopulationService(network: network)
    }
    
    override func tearDown() {
        super.tearDown()
        network = nil
        sut = nil
    }
    
    // MARK: - Tests
    
    func testFetchNationBuildsCorrectURL() async throws {
        // Given
        network.returnedValue = NationDTO.dummyInstance
        let expectedURL = "https://datausa.io/api/data?drilldowns=Nation&measures=Population&year"
        
        // When
        let _ = try await sut.fetchNation()
        
        // Then
        XCTAssertTrue(network.performRequestCalled)
        XCTAssertEqual(network.requestSpy?.url?.absoluteString, expectedURL)
    }
    
    func testFetchNationReturnsExpectedObject() async throws {
        // Given
        network.returnedValue = NationDTO.dummyInstance
        let expectedResult = NationDTO.dummyInstance
        
        // When
        let result = try await sut.fetchNation()
        
        // Then
        XCTAssertEqual(result.data, expectedResult.data)
    }
    
    func testFetchStatesBuildsCorrectURL() async throws {
        // Given
        network.returnedValue = StateDTO.dummyInstance
        let expectedYear = "2000"
        let expectedURL = "https://datausa.io/api/data?drilldowns=State&measures=Population&year=\(expectedYear)"
        
        // When
        let _ = try await sut.fetchStates(year: expectedYear)
        
        // Then
        XCTAssertTrue(network.performRequestCalled)
        XCTAssertEqual(network.requestSpy?.url?.absoluteString, expectedURL)
    }
}
