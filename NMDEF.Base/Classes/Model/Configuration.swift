//
// Created by Róbert PAPP on 2019-02-15.
//

public class Configuration: Codable {

    public var name: String

    public var id: Int

    public init(name: String, id: Int) {
        self.name = name
        self.id = id
    }
    
    enum CodingKeys: String, CodingKey {
        case id = "Id"
        case name = "Name"
    }
}
