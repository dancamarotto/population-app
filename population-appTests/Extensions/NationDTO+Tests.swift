@testable import population_app

extension NationDTO {
    static var dummyInstance: NationDTO {
        let nationOne = NationDTO.Data(id: "1", name: "nation-one", year: "2001", population: 1000)
        let nationTwo = NationDTO.Data(id: "2", name: "nation-two", year: "2002", population: 2000)
        return NationDTO(data: [nationOne, nationTwo])
    }
}
