//
// Created by Papp Imre on 2019-02-14.
// Copyright (c) 2019 CocoaPods. All rights reserved.
//

import NMDEF_Base
import RxCocoa
import RxSwift

class Nav1ViewModel: BaseViewModel {
    let menuCommand = PublishRelay<Void>()
    let nextCommand = PublishRelay<Void>()
    let loginCommand = PublishRelay<Void>()

    let email = BehaviorRelay<String?>(value: nil)
    let password = BehaviorRelay<String?>(value: nil)

    private var sessionId: String = ""

    private var relatedConfigs: [Configuration] = [Configuration]()

    required init() {
        super.init()

        print("URL: \(AppDelegate.settings.appName)")

        title.val = "Nav1"
        email.val = "demo@xapt.com"
        password.val = "xapt2017"

        nextCommand += {
            self.next(step: AppStep.nav2)
        } => self.disposeBag

        menuCommand += {
            self.next(step: AppStep.menu)
        } => self.disposeBag

        loginCommand += {
            let request = LoginRequest(email: self.email.value!, password: self.password.value!)

            self.callLoginService(request: request)
        } => self.disposeBag

        self.rx.viewCreated += {
            print("View created");
        } => self.disposeBag

        self.rx.viewAppearing += {
            print("View appearing");
        } => self.disposeBag
    }

    private func callLoginService(request: LoginRequest) {

        let userAuthService = AppDelegate.instance.container.resolve(UserAuthServiceProtocol.self)

        userAuthService!.login(request: request)
                .flatMap { response -> Observable<LoginResponse> in
                    if (response.configs.count > 1) {
                        return userAuthService!.selectConfig(id: response.configs[0].id, sessionId: response.token)
                    }
                    
                    return Observable.of(response)
                }
                .flatMap { response -> Observable<String> in
                     //TODO: set values because one config is available
                    //TODO Return response instead of string
                    return userAuthService!.getWorkerData(token: response.token)
                }
                .map { response -> Void in
                    //TODO: set values of get worker data
                    print("get data area id started")
                }
                .observeOn(ConcurrentDispatchQueueScheduler(qos: .background))
                .subscribeOn(MainScheduler.instance)
                .subscribe({ configResponse in
                    switch configResponse {
                    case .next(let response):
                        print(response)
                    case .completed:
                        print("login completed")
                    case .error:
                        print("error")
                    }
                }) => self.disposeBag
    }
}
