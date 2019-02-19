//
// Created by Róbert PAPP on 2019-02-18.
//

import Moya

public class UserAuthService: UserAuthServiceProtocol {

    var Context: UserAuthContext?

    public var provider = MoyaProvider<AuthServices>()

    public init() {
    }

    public func Login(request: LoginRequest) {
        Context = UserAuthContext(userIdentifier: request.email, password: request.password)

        provider.rx.request(.login).subscribe { event in
            switch event {
            case let .success(response):
                let result = response.data
            case let .error(error):
                print(error)
            }
        }
    }
}
