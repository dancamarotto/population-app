
import SwiftUI

struct NationCell: View {
    var nation: Nation
    
    var body: some View {
        VStack {
            HStack {
                Text(nation.name)
                Spacer()
                Text(nation.year)
            }
            .padding(.bottom)
            HStack {
                Text("Population: \(nation.population)")
                Spacer()
            }
            .padding(.bottom)
        }
    }
}

#Preview {
    let nation = Nation(
        id: "1",
        name: "United States",
        year: "2000",
        population: "100 000 000"
    )
    NationCell(nation: nation)
}
