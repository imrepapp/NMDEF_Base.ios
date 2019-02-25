// https://github.com/Quick/Quick

import Quick
import Nimble
import NMDEF_Base
import RxSwift
import Spry
import Moya

class UserAuthServiceTests: QuickSpec {

    private var userAuthService: UserAuthServiceProtocol = UserAuthService()
    private var correctLoginRequest = LoginRequest(email: "mobile@xapt.com", password: "xapt2017")

    override func setUp() {
        super.setUp()
    }

    override func spec() {

        describe("User Auth Service tests") {

            context("UserAuthService_WithCorrectParameters_ShouldPass") {

                let goodDataResponse = "{\"Token\": \"Token\"}".data(using: .utf8)

                let serverSuccessProviderClosure = { (target: AuthServices) -> Endpoint in
                    return Endpoint(url: URL(target: target).absoluteString,
                            sampleResponseClosure: { .networkResponse(200 , goodDataResponse!) },
                            method: target.method,
                            task: target.task,
                            httpHeaderFields: target.headers)
                }
                let serverSuccessProvider = MoyaProvider<AuthServices>(endpointClosure: serverSuccessProviderClosure, stubClosure: MoyaProvider.immediatelyStub)
                self.userAuthService.provider = serverSuccessProvider
                
                it("UserAuthService_WithCorrectParameters_ShouldPass") {
                    self.userAuthService.login(request: self.correctLoginRequest)
                            .observeOn(ConcurrentDispatchQueueScheduler(qos: .background))
                            .subscribeOn(MainScheduler.instance)
                            .subscribe { completable in
                                switch completable {
                                case .success(let response):
                                    print(response.token)
                                case .error(let error):
                                    print("Completed with an error: \(error.localizedDescription)")
                                }
                            }.dispose()
                }
            }
        }
    }
}
