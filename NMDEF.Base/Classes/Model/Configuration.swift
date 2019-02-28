//
// Created by Róbert PAPP on 2019-02-15.
//

import Foundation

public class Configuration: Decodable {

    public var name: String

    public var id: Int

    init(name: String, id: Int) {
        self.name = name
        self.id = id
    }
    
    enum CodingKeys: String, CodingKey {
        case id = "Id"
        case name = "Name"
    }
}
