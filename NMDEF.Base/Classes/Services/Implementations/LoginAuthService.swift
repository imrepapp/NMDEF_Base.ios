//
// Created by Róbert PAPP on 2019-03-04.
//

import RxSwift
import Moya

public class LoginAuthService<TLoginResponse: LoginResponse>: LoginAuthServiceProtocol {
    public func login(request: LoginRequest) -> Observable<LoginResponse> {
        return loginGeneric(request: request) as! Observable<LoginResponse>
    }

    public func selectConfig(id: Int, sessionId: String) -> Observable<LoginResponse> {
        return selectConfigGeneric(id: id, sessionId: sessionId) as! Observable<LoginResponse>
    }

    public func parseResponseByResponseType(response: Data) -> LoginResponse {
        return parseResponseByResponseTypeGeneric(response: response) as LoginResponse
    }

    public init(){

    }

    public var provider = MoyaProvider<AuthServices>()

    private func loginGeneric(request: LoginRequest) -> Observable<TLoginResponse> {
        return Observable<TLoginResponse>.create { observer in

            let disposable = self.provider.rx.request(.login(emailAddress: request.email, password: request.password)).subscribe { event in
                switch event {
                case let .success(response):
                    self.parseAndPrintResponse(data: response.data)

                    let loginResponse = self.parseResponseByResponseTypeGeneric(response: response.data)
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

    private func selectConfigGeneric(id: Int, sessionId: String) -> Observable<TLoginResponse> {
        return Observable<TLoginResponse>.create { observer in

            let disposable = self.provider.rx.request(.selectConfig(id: id, sessionId: sessionId)).subscribe { event in
                switch event {
                case let .success(response):
                    self.parseAndPrintResponse(data: response.data)

                    let loginResponse = self.parseResponseByResponseTypeGeneric(response: response.data)
                    observer.onNext(loginResponse)

                case let .error(error):
                    observer.onError(error)
                    print(error)
                }
            }
            return disposable
        }
    }

    private func parseResponseByResponseTypeGeneric(response: Data) -> TLoginResponse {
        do {
            guard let loginResponse = try? JSONDecoder().decode(TLoginResponse.self, from: response) else {
                throw LoginRequestParsingError.jsonParsingError("Error in parsing login response")
            }
            print("Login response parsed successfully with the following data\(loginResponse)")
            return loginResponse
        } catch {
            print("Error happened during login response parsing")
            return LoginResponse(token: "", configs: [Configuration]()) as! TLoginResponse
        }
    }

    //TODO: Make extension instead of private method
    private func parseAndPrintResponse(data: Data) {
        let encodedResponse = String(data: data, encoding: .utf8)
        print(encodedResponse ?? "No data received from server")
    }
}
