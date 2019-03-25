//
// Created by Róbert PAPP on 2019-02-18.
//

import Moya
import RxSwift

public class UserAuthService : UserAuthServiceProtocol{

    public var loginAuthServiceProtocol: LoginAuthServiceProtocol
    public var hcmWorkerAuthServiceProtocol: HcmWorkerAuthServiceProtocol

    public func login(request: LoginRequest) -> Single<LoginResponse> {
        return loginAuthServiceProtocol.login(request: request)
    }

    public func selectConfig(id: Int, sessionId: String) -> Single<LoginResponse> {
        return loginAuthServiceProtocol.selectConfig(id: id, sessionId: sessionId)
    }

    public func getWorkerData() -> Single<WorkerData> {
       return hcmWorkerAuthServiceProtocol.getWorkerData()
    }

    public init(loginAuthServiceProtocol: LoginAuthServiceProtocol,
                hcmWorkerAuthServiceProtocol: HcmWorkerAuthServiceProtocol) {
        self.loginAuthServiceProtocol = loginAuthServiceProtocol
        self.hcmWorkerAuthServiceProtocol = hcmWorkerAuthServiceProtocol
    }
}

