//
// Created by Róbert PAPP on 2019-02-18.
//

import Moya

class UserAuthService: UserAuthServiceProtocol {

    var Context: UserAuthContext?

    init(){

    }

    func Login(request: LoginRequest) {
        Context = UserAuthContext(userIdentifier: request.email, password: request.password)

        var provider = MoyaProvider<AuthServices>()
    }

}
