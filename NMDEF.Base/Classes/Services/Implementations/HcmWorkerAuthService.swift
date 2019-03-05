//
// Created by Róbert PAPP on 2019-03-04.
//

import RxSwift
import Moya

public class HcmWorkerAuthService<THcmWorker: WorkerData>: HcmWorkerAuthServiceProtocol {
    public var provider = MoyaProvider<AuthServices>()

    public init(){

    }

    public func getWorkerData(token: String) -> Observable<WorkerData> {
        return getWorkerDataGeneric(token: token) as! Observable<WorkerData>
    }

    public func parseResponseByHcmWorkerType(response: Data) throws -> WorkerData {
        return try parseResponseByHcmWorkerTypeGeneric(response: response) as WorkerData
    }

    private func getWorkerDataGeneric(token: String) -> Observable<THcmWorker> {
        return Observable<THcmWorker>.create { observer in

            let disposable = self.provider.rx.request(.getWorkerData(token: token)).subscribe { event in
                switch event {
                case let .success(response):
                    self.parseAndPrintResponse(data: response.data)
                    do {
                        let workerData = try self.parseResponseByHcmWorkerTypeGeneric(response: response.data)
                        observer.onNext(workerData)
                        observer.onCompleted()
                    } catch {
                        observer.onError(LoginParsingError.jsonParsingError("Error in parsing login response"))
                    }

                case let .error(error):
                    observer.onError(error)
                    print(error)
                }
            }
            return disposable
        }
    }

    private func parseResponseByHcmWorkerTypeGeneric(response: Data) throws -> THcmWorker {
        do {
            guard let workerDataResponse = try? JSONDecoder().decode(THcmWorker.self, from: response) else {
                throw LoginParsingError.jsonParsingError("Error in parsing login response")
            }

            print("Login response parsed successfuly with the following data\(workerDataResponse)")
            return workerDataResponse as THcmWorker

        }
    }

    private func parseAndPrintResponse(data: Data) {
        let encodedResponse = String(data: data, encoding: .utf8)
        print(encodedResponse ?? "No data received from server")
    }
}
