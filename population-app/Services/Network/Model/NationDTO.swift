struct NationDTO: Decodable, Equatable {
    let data: [Data]
}

extension NationDTO {
    struct Data: Decodable, Equatable {
        let id: String
        let name: String
        let year: String
        let population: UInt
        
        enum CodingKeys: String, CodingKey {
            case id = "ID Nation"
            case name = "Nation"
            case year = "Year"
            case population = "Population"
        }
    }
}
