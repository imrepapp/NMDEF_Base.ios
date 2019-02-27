//
// Created by Róbert PAPP on 2019-02-18.
//

import Moya
import RxSwift

public class UserAuthService: UserAuthServiceProtocol {

    public var provider = MoyaProvider<AuthServices>()

    public init() {
    }

    public func login(request: LoginRequest) -> Observable<LoginResponse> {
        return Observable<LoginResponse>.create { observer in

            self.provider.rx.request(.login(emailAddress: request.email, password: request.password)).subscribe { event in
                switch event {
                case let .success(response):
                    self.parseAndPrintResponse(data: response.data)

                    let loginResponse = self.parseResponseToLoginResponse(response: response.data)
                    observer.onNext(loginResponse)
                    observer.onCompleted()

                case let .error(error):
                    observer.onError(error)
                    print(error)
                }
            }
            return Disposables.create()
        }
    }

    public func selectConfig(id: Int, sessionId: String) -> Observable<LoginResponse> {
        return Observable<LoginResponse>.create { observer in

            self.provider.rx.request(.selectConfig(id: id, sessionId: sessionId)).subscribe { event in
                switch event {
                case let .success(response):
                    self.parseAndPrintResponse(data: response.data)

                    let loginResponse = self.parseResponseToLoginResponse(response: response.data)
                    observer.onNext(loginResponse)

                case let .error(error):
                    observer.onError(error)
                    print(error)
                }
            }
            return Disposables.create()
        }
    }

    public func getDataAreaId(token: String) -> Single<String> {
        fatalError("getDataAreaId(token:) has not been implemented")
    }

    public func getHcmWorkerId(token: String) -> Single<String> {
        fatalError("getHcmWorkerId(token:) has not been implemented")
    }

    public func getCurrentUserId(token: String) -> Single<String> {
        fatalError("getCurrentUserId(token:) has not been implemented")
    }

    private func parseResponseToLoginResponse(response: Data) -> LoginResponse {
        let loginResponse = LoginResponse(token: "", configs: [Configuration]())

        do {
           let json = try JSONSerialization.jsonObject(with: response, options: .allowFragments) as! [String: AnyObject]
            if let tokenValue = json["Token"] as? String {
                loginResponse.token = tokenValue
            }
            if let configurations = json["Configs"] as? NSArray {
                for (config) in configurations {
                    let keyValuePair = config as! NSDictionary
                    let name = keyValuePair["Name"] as! String
                    let id = keyValuePair["Id"] as! Int
                    let parsedConfig = Configuration(name: name, id: String(id))

                    loginResponse.configs.append(parsedConfig)
                }
            }
        } catch let error as NSError {
            print("Failed to load: \(error.localizedDescription)")
        }

        return loginResponse
    }

    private func parseAndPrintResponse(data: Data){
        let encodedResponse = String(data: data, encoding: .utf8)
        print(encodedResponse)
    }
}
