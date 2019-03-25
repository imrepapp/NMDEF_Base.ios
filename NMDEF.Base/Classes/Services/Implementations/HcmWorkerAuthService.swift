//
// Created by Róbert PAPP on 2019-03-04.
//

import RxSwift
import Moya

public class HcmWorkerAuthService<THcmWorker: WorkerData>: HcmWorkerAuthServiceProtocol {
    public var provider = MoyaProvider<AuthServices>()

    public init() {
    }

    public func getWorkerData() -> Single<WorkerData> {
        return self.provider.rx.send(.getWorkerData(token: BaseAppDelegate.instance.token!))
    }
}
