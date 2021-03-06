//
// Created by Róbert PAPP on 2019-02-15.
//

enum LoginRequestParsingError: Error {
    case jsonParsingError(String)
}

public class LoginRequest {

    var email: String

    var password: String

    public init(email: String, password: String){
        self.email  = email
        self.password = password
    }
}
