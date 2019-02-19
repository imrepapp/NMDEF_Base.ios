//
// Created by Róbert PAPP on 2019-02-18.
//

import Moya

public protocol UserAuthServiceProtocol {

    var provider: MoyaProvider<AuthServices> { get }

    func Login(request: LoginRequest)
}
