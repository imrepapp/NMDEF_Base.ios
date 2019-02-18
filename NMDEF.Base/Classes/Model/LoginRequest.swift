//
// Created by Róbert PAPP on 2019-02-15.
//

import Foundation

class LoginRequest {

    var email: String

    var password: String

    init(email: String, password: String){
        self.email  = email
        self.password = password
    }
}
