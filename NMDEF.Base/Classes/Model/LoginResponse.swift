//
// Created by Róbert PAPP on 2019-02-21.
//

import Foundation

public class LoginResponse {
    public var token: String

    public var configs = [Configuration]()

    init(token: String, configs: [Configuration]) {
        self.token = token
        self.configs = configs
    }
}
