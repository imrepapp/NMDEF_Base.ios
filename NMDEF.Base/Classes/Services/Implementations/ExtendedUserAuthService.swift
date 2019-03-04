//
// Created by Róbert PAPP on 2019-03-04.
//

import RxSwift
import Moya

public class ExtendedUserAuthService: UserAuthService {

    override var provider: Moya.MoyaProvider<AuthServices> {
        get {
            return super.provider
        }
        set {
            super.provider = newValue
        }
    }

    override func getWorkerData(token: String) -> RxSwift.Observable<WorkerData> {
        return Observable<WorkerData>.create { observer in

            let disposable = self.provider.rx.request(.getWorkerData(token: token)).subscribe { event in
                switch event {
                case let .success(response):
                    self.parseAndPrintResponse(data: response.data)
                    let workerData = self.parseResponseByHcmWorkerType(response: response.data)

                    observer.onNext(workerData)

                case let .error(error):
                    observer.onError(error)
                    print(error)
                }
            }
            return disposable
        }
    }
}
