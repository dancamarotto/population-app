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
        populationService.returnedNationDTO = buildDummyNationDTO()
        XCTAssertEqual(sut.nations, [])
        
        // When
        await sut.fetchNation()
        
        // Then
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
        XCTAssertEqual(sut.nations.count, 0)
    }
    
    // MARK: - Private functions
    
    private func buildDummyNationDTO() -> NationDTO {
        let nationOne = NationDTO.Data(id: "1", name: "nation-one", year: "2001", population: 1000)
        let nationTwo = NationDTO.Data(id: "2", name: "nation-two", year: "2002", population: 2000)
        return NationDTO(data: [nationOne, nationTwo])
    }
}
