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

    required init() {
        super.init()

        print("URL: \(AppDelegate.settings.exampleVar)")

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

            let userAuthResult = self.callLoginService(request: request)
        } => self.disposeBag
    }

    private func callLoginService(request: LoginRequest) -> UserAuthResult {
        let userAuthService = AppDelegate.instance.container.resolve(UserAuthServiceProtocol.self)
        var defaultUserAuthResult = UserAuthResult.errorData
        
        userAuthService!.login(request: request)
                .observeOn(ConcurrentDispatchQueueScheduler(qos: .background))
                .subscribeOn(MainScheduler.instance)
                .subscribe { completable in
                    switch completable {
                    case .success(let response):
                        if response.configs.count == 1{
                            BaseAppDelegate.token = response.token
                            let settings = BaseAppDelegate.instance.container.resolve(BaseSettings.self)
                            settings!.userAuthContext!.selectedConfig = response.configs[0]
                            defaultUserAuthResult =  UserAuthResult.success
                        }
                        if response.configs.count > 1 {
                            defaultUserAuthResult = UserAuthResult.ambiguous
                        }

                        print(response.token)
                    case .error(let error):
                        print("Completed with an error: \(error.localizedDescription)")
                        defaultUserAuthResult = UserAuthResult.errorData
                    }
                } => self.disposeBag
        
        return defaultUserAuthResult
    }
}
