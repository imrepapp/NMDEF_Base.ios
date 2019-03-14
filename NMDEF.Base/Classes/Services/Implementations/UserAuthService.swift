//
// Created by Róbert PAPP on 2019-02-18.
//

import Moya
import RxSwift

public class UserAuthService : UserAuthServiceProtocol{

    public var loginAuthServiceProtocol: LoginAuthServiceProtocol
    public var hcmWorkerAuthServiceProtocol: HcmWorkerAuthServiceProtocol

    public func login(request: LoginRequest) -> Observable<LoginResponse> {
        return loginAuthServiceProtocol.login(request: request)
    }

    public func selectConfig(id: Int, sessionId: String) -> Observable<LoginResponse> {
        return loginAuthServiceProtocol.selectConfig(id: id, sessionId: sessionId)
    }

    public func getWorkerData() -> Observable<WorkerData> {
       return hcmWorkerAuthServiceProtocol.getWorkerData()
    }

    public init(loginAuthServiceProtocol: LoginAuthServiceProtocol,
                hcmWorkerAuthServiceProtocol: HcmWorkerAuthServiceProtocol) {
        self.loginAuthServiceProtocol = loginAuthServiceProtocol
        self.hcmWorkerAuthServiceProtocol = hcmWorkerAuthServiceProtocol
    }

    private func parseAndPrintResponse(data: Data) {
        let encodedResponse = String(data: data, encoding: .utf8)
        print(encodedResponse ?? "No data received from server")
    }
}

