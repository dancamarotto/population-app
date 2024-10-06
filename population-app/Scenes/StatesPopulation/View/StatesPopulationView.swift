import SwiftUI

struct StatesPopulationView: View {
    let year: String
    
    @StateObject var viewModel: StatesPopulationViewModel
    
    init(year: String) {
        self.year = year
        let viewModel = StatesPopulationViewModel(year: year)
        _viewModel = StateObject(wrappedValue: viewModel)
    }
    
    var body: some View {
        List(viewModel.states, id: \.self) { state in
            StateCell(state: state)
        }
        .task {
            await viewModel.fetchStates()
        }
    }
}
