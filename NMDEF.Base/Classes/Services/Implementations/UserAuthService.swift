//
// Created by Róbert PAPP on 2019-02-18.
//

import Moya
import RxSwift

public class UserAuthService: UserAuthServiceProtocol {

    var Context: UserAuthContext?

    public var provider = MoyaProvider<AuthServices>()

    public init() {
    }

    public func Login(request: LoginRequest) -> Completable {
        return Completable.create { single in

            self.Context = UserAuthContext(userIdentifier: request.email, password: request.password)
            self.provider.rx.request(.login(emailAddress: request.email, password: request.password)).subscribe { event in
                switch event {
                case let .success(response):
                    let response = self.parseResponseToLoginResponse(response: response.data)
                    single(.completed)
                        //print("HttpStatus code \(response.statusCode)")
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
        } catch let error as NSError {
            print("Failed to load: \(error.localizedDescription)")
        }

        return loginResponse
    }
}
