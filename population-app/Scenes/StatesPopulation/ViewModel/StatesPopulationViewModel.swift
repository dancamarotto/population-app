import Foundation

final class StatesPopulationViewModel: ObservableObject {
    private let year: String
    private let populationService: PopulationServiceProtocol
    
    @Published var states: [State] = []
    
    init(year: String, populationService: PopulationServiceProtocol = PopulationService()) {
        self.year = year
        self.populationService = populationService
    }
    
    func fetchStates() async {
        do {
            let statesDTO = try await populationService.fetchStates(year: year)
            let states = statesDTO.data.map { State($0) }
            await update(states: states)
        } catch {
            print("Something unexpected happened, please try again later.")
        }
    }
    
    @MainActor
    private func update(states: [State]) {
        self.states = states
    }
}
