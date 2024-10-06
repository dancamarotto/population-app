struct StateDTO: Decodable {
    let data: [StateDTO.Data]
}

extension StateDTO {
    struct Data: Decodable {
        let id: String
        let name: String
        let year: String
        let population: UInt
        
        enum CodingKeys: String, CodingKey {
            case id = "ID State"
            case name = "State"
            case year = "Year"
            case population = "Population"
        }
    }
}
