
import SwiftUI

struct StateCell: View {
    var state: State
    
    var body: some View {
        VStack {
            HStack {
                Text(state.name)
                Spacer()
                Text(state.year)
            }
            .padding(.bottom)
            HStack {
                Text("Population: \(state.population)")
                Spacer()
            }
            .padding(.bottom)
        }
    }
}

#Preview {
    let state = State(
        id: "1",
        name: "New York",
        year: "2000",
        population: "1 000 000"
    )
    StateCell(state: state)
}
