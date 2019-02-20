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

        provider.rx.request(.login(emailAddress: request.email, password: request.password)).subscribe { event in
            switch event {
            case let .success(response):
                let result = String(data: response.data, encoding: .utf8)
                print("HttpStatus code \(response.statusCode)")
            case let .error(error):
                print(error)
            }
        }
    }
}
