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

    public func parseResponseByResponseType(response: Data) throws -> LoginResponse {
        return try parseResponseByResponseTypeGeneric(response: response) as LoginResponse
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

                    do {
                        let loginResponse = try self.parseResponseByResponseTypeGeneric(response: response.data)
                        observer.onNext(loginResponse)
                        observer.onCompleted()
                    } catch {
                        observer.onError(error)
                    }
                case let .error(error):
                    observer.onError(error)
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

                    do{
                        let loginResponse = try self.parseResponseByResponseTypeGeneric(response: response.data)
                        observer.onNext(loginResponse)
                        observer.onCompleted()
                    }
                    catch{
                        observer.onError(error)
                    }

                case let .error(error):
                    observer.onError(error)
                    print(error)
                }
            }
            return disposable
        }
    }

    private func parseResponseByResponseTypeGeneric(response: Data) throws -> TLoginResponse {
        do {
            guard let loginResponse = try? JSONDecoder().decode(TLoginResponse.self, from: response) else {
                let json = try JSONSerialization.jsonObject(with: response, options: []) as! [String: AnyObject]
                if let msg = json["Message"] as? String {
                    throw LoginParsingError.loginError(msg)
                }
                throw LoginParsingError.jsonParsingError("Error in parsing login response")
            }
            print("Login response parsed successfully with the following data\(loginResponse)")
            return loginResponse
        }
    }

    //TODO: Make extension instead of private method
    private func parseAndPrintResponse(data: Data) {
        let encodedResponse = String(data: data, encoding: .utf8)
        print(encodedResponse ?? "No data received from server")
    }
}
