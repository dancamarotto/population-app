import Foundation

protocol StatesPopulationViewModelProtocol {
    var states: [State] { get }
    
    func fetchStates() async
}

final class StatesPopulationViewModel: ObservableObject {
    private let year: String
    private let populationService: PopulationServiceProtocol
    
    @Published var states: [State] = []
    
    init(year: String, populationService: PopulationServiceProtocol = PopulationService()) {
        self.year = year
        self.populationService = populationService
    }
    
    @MainActor
    private func update(states: [State]) {
        self.states = states
    }
}

extension StatesPopulationViewModel: StatesPopulationViewModelProtocol {
    func fetchStates() async {
        do {
            let statesDTO = try await populationService.fetchStates(year: year)
            let states = statesDTO.data.map { State($0) }
            await update(states: states)
        } catch {
            print("Something unexpected happened, please try again later.")
        }
    }
}
