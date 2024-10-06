import XCTest
@testable import population_app

final class NationPopulationViewModelTests: XCTestCase {
    var sut: NationPopulationViewModel!
    var populationService: PopulationServiceMock!
    
    override func setUp() {
        populationService = PopulationServiceMock()
        sut = NationPopulationViewModel(populationService: populationService)
    }
    
    override func tearDown() {
        populationService = nil
        sut = nil
    }
    
    // MARK: - Tests
    
    func testFetchNationReturnsValueFromService() async {
        // Given
        populationService.returnedNationDTO = NationDTO.dummyInstance
        XCTAssertEqual(sut.nations, [])
        
        // When
        await sut.fetchNation()
        
        // Then
        XCTAssertTrue(populationService.fetchNationCalled)
        XCTAssertEqual(sut.nations.count, 2)
        let actualOne = sut.nations.first { $0.id == "1" }
        XCTAssertEqual(actualOne?.name, "nation-one")
        XCTAssertEqual(actualOne?.year, "2001")
        XCTAssertEqual(actualOne?.population, UInt(1000).formattedWithSeparator())
    }
    
    func testFetchNationDoesNotUpdateNationsListWhenServiceThrows() async {
        // Given
        populationService.shouldFetchNationThrow = true
        XCTAssertEqual(sut.nations, [])
        
        // When
        await sut.fetchNation()
        
        // Then
        XCTAssertTrue(populationService.fetchNationCalled)
        XCTAssertEqual(sut.nations.count, 0)
    }
}
