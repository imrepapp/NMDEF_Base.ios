//
// Created by Róbert PAPP on 2019-02-28.
//

import RxSwift

public protocol HcmWorkerAuthServiceProtocol {

    func getWorkerData() -> Single<WorkerData>
}
