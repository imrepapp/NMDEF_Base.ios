//
// Created by Róbert PAPP on 2019-02-18.
//

import Moya
import RxSwift

public protocol UserAuthServiceProtocol {

    var provider: MoyaProvider<AuthServices> { get set}

    func login(request: LoginRequest) -> Observable<LoginResponse>

    func selectConfig(id: Int, sessionId: String) -> Observable<LoginResponse>

    func getDataAreaId(token: String) -> Single<String>

    func getHcmWorkerId(token: String) -> Single<String>

    func getCurrentUserId(token: String) -> Single<String>
}
