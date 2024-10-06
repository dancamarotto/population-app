@testable import population_app

extension StateDTO {
    static var dummyInstance: StateDTO {
        let stateOne = StateDTO.Data(id: "1", name: "state-one", year: "2001", population: 1000)
        let stateTwo = StateDTO.Data(id: "2", name: "state-two", year: "2002", population: 2000)
        return StateDTO(data: [stateOne, stateTwo])
    }
}
