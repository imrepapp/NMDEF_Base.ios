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
        var userAuthResultResponse = UserAuthResult.undefined

        userAuthService!.login(request: request)
                .observeOn(ConcurrentDispatchQueueScheduler(qos: .background))
                .subscribeOn(MainScheduler.instance)
                .subscribe {
                    completable in
                    switch completable {
                    case .next(let response):
                        if response.configs.count == 1 {
                            BaseAppDelegate.token = response.token

                            let settings = BaseAppDelegate.instance.container.resolve(BaseSettings.self)
                            settings!.userAuthContext!.selectedConfig = response.configs[0]
                            userAuthResultResponse = UserAuthResult.success
                        }
                        if response.configs.count > 1 {
                            self.sessionId = response.token
                            self.relatedConfigs = response.configs
                            userAuthResultResponse = UserAuthResult.ambiguous
                        }

                        print(response.token)
                    case .error(let error):
                        print("Completed with an error: \(error.localizedDescription)")
                        userAuthResultResponse = UserAuthResult.errorData
                    case .completed:
                        if (userAuthResultResponse == UserAuthResult.ambiguous) {
                            let selectedConfig = self.relatedConfigs[0]
                            userAuthService?.selectConfig(id: selectedConfig.id, sessionId: self.sessionId)
                                    .observeOn(ConcurrentDispatchQueueScheduler(qos: .background))
                                    .subscribeOn(MainScheduler.instance)
                                    .subscribe { completable in
                                        switch completable {
                                        case .next(let response):
                                            //TODO set token and config
                                            userAuthResultResponse  = UserAuthResult.success
                                            print(response)
                                        case .completed:
                                            print("Completed")
                                        case .error(let error):
                                            print(error)
                                        }
                                    }
                        }
                        print("Login finished")
                    }
                } => self.disposeBag
    }

    private func handleConfigSelection(defaultUserAuthResult: UserAuthResult) {
        if (defaultUserAuthResult == UserAuthResult.ambiguous) {


        }
    }

}
