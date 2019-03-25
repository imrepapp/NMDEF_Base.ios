//
// Created by Róbert PAPP on 2019-03-04.
//

import Moya
import RxSwift

public protocol UserAuthServiceProtocol {
    //var provider: MoyaProvider<AuthServices> { get set}

    func login(request: LoginRequest) -> Single<LoginResponse>

    func selectConfig(id: Int, sessionId: String) -> Single<LoginResponse>

    func getWorkerData() -> Single<WorkerData>
}
