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

            let userAuthService = AppDelegate.instance.container.resolve(UserAuthServiceProtocol.self)
            userAuthService!.Login(request: request)
                    .observeOn(ConcurrentDispatchQueueScheduler(qos: .background))
                    .subscribeOn(MainScheduler.instance)
                    .subscribe { completable in
                        switch completable {
                        case .success(let response):
                            print(response.token)
                        case .error(let error):
                            print("Completed with an error: \(error.localizedDescription)")
                        }
                    }
                    .disposed(by: self.disposeBag)
        }
    }
}
