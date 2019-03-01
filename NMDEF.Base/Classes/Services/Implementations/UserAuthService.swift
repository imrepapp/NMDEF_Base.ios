//
// Created by Róbert PAPP on 2019-02-18.
//

import Moya
import RxSwift

public class UserAuthService: UserAuthServiceProtocol, JsonParserProtocol {

    public var provider = MoyaProvider<AuthServices>()
    typealias ResponseType = LoginResponse

    public init() {
    }

    public func login(request: LoginRequest) -> Observable<LoginResponse> {
        return Observable<LoginResponse>.create { observer in

            let disposable = self.provider.rx.request(.login(emailAddress: request.email, password: request.password)).subscribe { event in
                switch event {
                case let .success(response):
                    self.parseAndPrintResponse(data: response.data)

                    let loginResponse = self.parseResponseByResponseType(response: response.data)
                    observer.onNext(loginResponse)
                    observer.onCompleted()

                case let .error(error):
                    observer.onError(error)
                    print(error)
                }
            }
            return disposable
        }
    }

    public func selectConfig(id: Int, sessionId: String) -> Observable<LoginResponse> {
        return Observable<LoginResponse>.create { observer in

            let disposable = self.provider.rx.request(.selectConfig(id: id, sessionId: sessionId)).subscribe { event in
                switch event {
                case let .success(response):
                    self.parseAndPrintResponse(data: response.data)

                    let loginResponse = self.parseResponseByResponseType(response: response.data)
                    observer.onNext(loginResponse)

                case let .error(error):
                    observer.onError(error)
                    print(error)
                }
            }
            return disposable
        }
    }

    public func getWorkerData(token: String) -> Observable<String> {
        return Observable<String>.create { observer in

            let disposable = self.provider.rx.request(.getWorkerData(token: token)).subscribe { event in
                switch event {
                case let .success(response):
                    print("Get data area id")
                    self.parseAndPrintResponse(data: response.data)

                    observer.onNext("getDataAreaId")

                case let .error(error):
                    observer.onError(error)
                    print(error)
                }
            }
            return disposable
        }
    }

    func parseResponseByResponseType(response: Data) -> LoginResponse {
        do {
            guard let loginResponse = try? JSONDecoder().decode(LoginResponse.self, from: response) else {
                throw LoginRequestParsingError.jsonParsingError("Error in parsing login response")
            }

            print("Login response parsed successfuly with the following data\(loginResponse)")
            return loginResponse

        } catch let error as NSError {
            print("Failed to load: \(error.localizedDescription)")
            return LoginResponse(token: "", configs: [Configuration]())
        }
    }

    private func parseAndPrintResponse(data: Data) {
        let encodedResponse = String(data: data, encoding: .utf8)
        print(encodedResponse ?? "No data received from server")
    }
}

