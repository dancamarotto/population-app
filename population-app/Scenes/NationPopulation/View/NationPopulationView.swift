import SwiftUI

struct NationPopulationView: View {
    @StateObject var viewModel = NationPopulationViewModel()
    
    var body: some View {
        NavigationView {
            List(viewModel.nations, id: \.self) { nation in
                NavigationLink(destination: StatesPopulationView(year: nation.year)) {
                    NationCell(nation: nation)
                }
            }
        }
        .task {
            await viewModel.fetchNation()
        }
    }
}

#Preview {
    NationPopulationView()
}
