//
// Created by Papp Imre on 2019-02-14.
// Copyright (c) 2019 CocoaPods. All rights reserved.
//

import NMDEF_Base
import RxCocoa

class Nav1ViewModel: BaseViewModel {
    let menuCommand = PublishRelay<Void>()
    let nextCommand = PublishRelay<Void>()
    let loginCommand = PublishRelay<Void>()

    let email = BehaviorRelay<String?>(value: nil)
    let password = BehaviorRelay<String?>(value: nil)

    required init() {
        let userAuthService = UserAuthService()

        super.init()
        title.val = "Nav1"

        nextCommand += {
            self.next(step: AppStep.nav2)
        } => self.disposeBag

        menuCommand += {
            self.next(step: AppStep.menu)
        } => self.disposeBag
        
        loginCommand += {
            let request = LoginRequest(email: self.email.value!, password: self.password.value!)

            userAuthService.Login(request: request)

            self.next(step: AppStep.menu)
        } => self.disposeBag
    }
}
