//
// Created by Róbert PAPP on 2019-02-18.
//

import Moya
import RxSwift

public protocol LoginAuthServiceProtocol {

    var provider: MoyaProvider<AuthServices> { get set}

    func login(request: LoginRequest) -> Single<LoginResponse>

    func selectConfig(id: Int, sessionId: String) -> Single<LoginResponse>
}
