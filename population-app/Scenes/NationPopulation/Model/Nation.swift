struct Nation: Hashable {
    let id: String
    let name: String
    let year: String
    let population: String
    
    init(id: String, name: String, year: String, population: String) {
        self.id = id
        self.name = name
        self.year = year
        self.population = population
    }
    
    init(_ data: NationDTO.Data) {
        self.id = data.id
        self.name = data.name
        self.year = data.year
        self.population = data.population.formattedWithSeparator()
    }
}
