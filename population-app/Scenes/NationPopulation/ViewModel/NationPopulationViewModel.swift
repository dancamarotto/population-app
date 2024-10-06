import Foundation

protocol NationPopulationViewModelProtocol {
    var nations: [Nation] { get }
    
    func fetchNation() async
}

final class NationPopulationViewModel: ObservableObject, NationPopulationViewModelProtocol {
    private let populationService: PopulationServiceProtocol
    
    @Published var nations: [Nation] = []
    
    init(populationService: some PopulationServiceProtocol = PopulationService()) {
        self.populationService = populationService
    }
    
    func fetchNation() async {
        do {
            let nationDTO = try await populationService.fetchNation()
            let nations = nationDTO.data.map { Nation($0) }
            await update(nations: nations)
        } catch {
            print("Something unexpected happened, please try again later.")
        }
    }
    
    @MainActor
    private func update(nations: [Nation]) {
        self.nations = nations
    }
}
