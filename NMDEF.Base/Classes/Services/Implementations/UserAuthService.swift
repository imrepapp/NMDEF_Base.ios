//
// Created by Róbert PAPP on 2019-02-18.
//

import Moya
import RxSwift

public class UserAuthService: UserAuthServiceProtocol {

    public var provider = MoyaProvider<AuthServices>()

    public init() {
    }

    public func login(request: LoginRequest) -> Single<LoginResponse> {
        return Single<LoginResponse>.create { single in
            
            self.provider.rx.request(.login(emailAddress: request.email, password: request.password)).subscribe { event in
                switch event {
                case let .success(response):
                    let loginResponse = self.parseResponseToLoginResponse(response: response.data)
                    single(.success(loginResponse))

                case let .error(error):
                    single(.error(error))
                    print(error)
                }
            }
            return Disposables.create()
        }
    }

    private func parseResponseToLoginResponse(response: Data) -> LoginResponse {
        var loginResponse: LoginResponse = LoginResponse(token: "", configs: [Configuration]())

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
}
