//
// Created by Róbert PAPP on 2019-03-04.
//

import RxSwift
import Moya

public class LoginAuthService<TLoginResponse: LoginResponse>: LoginAuthServiceProtocol {

    public var provider = MoyaProvider<AuthServices>()

    public init(){        
    }

    public func login(request: LoginRequest) -> Single<LoginResponse> {
        return self.provider.rx.send(.login(emailAddress: request.email, password: request.password))
    }

    public func selectConfig(id: Int, sessionId: String) -> Single<LoginResponse> {
        return self.provider.rx.send(.selectConfig(id: id, sessionId: sessionId))
    }
}
