//
// Created by Róbert PAPP on 2019-02-21.
//

public class LoginResponse: Decodable, CustomStringConvertible {
    public var token: String

    public var configs = [Configuration]()

    init(token: String, configs: [Configuration]) {
        self.token = token
        self.configs = configs
    }

    enum CodingKeys: String, CodingKey {
        case token = "Token"
        case configs = "Configs"
    }

    public var description: String {
        var formattedString: String = token

        for config in configs {
            formattedString += "Config name: \(config.name) config id: \(String(config.id))"
        }
        return formattedString
    }
}
