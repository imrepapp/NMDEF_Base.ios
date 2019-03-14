//
// Created by Róbert PAPP on 2019-03-04.
//

import Moya
import RxSwift

public protocol UserAuthServiceProtocol {
    //var provider: MoyaProvider<AuthServices> { get set}

    func login(request: LoginRequest) -> Observable<LoginResponse>

    func selectConfig(id: Int, sessionId: String) -> Observable<LoginResponse>

    func getWorkerData() -> Observable<WorkerData>
}
