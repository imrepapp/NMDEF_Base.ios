//
// Created by Papp Imre on 2019-02-14.
// Copyright (c) 2019 CocoaPods. All rights reserved.
//

import NMDEF_Base
import RxCocoa


class Nav2ViewModel: BaseViewModel {
    let exampleVar = BehaviorRelay<String?>(value: AppDelegate.settings.exampleVar)

    let rememberMe = BehaviorRelay<Bool>(value: AppDelegate.settings.rememberMe)
    let userAuthContext = BehaviorRelay<UserAuthContext?>(value: AppDelegate.settings.userAuthContext)
    let autoLoginEnabled = BehaviorRelay<Bool>(value: AppDelegate.settings.autoLoginEnabled)

    let configAutomatic = BehaviorRelay<Bool>(value: AppDelegate.settings.syncConfig.automatic)
    let configIntervalFullSec = BehaviorRelay<Int>(value: AppDelegate.settings.syncConfig.intervalFullSec)
    let configIntervalPartSec = BehaviorRelay<Int>(value: AppDelegate.settings.syncConfig.intervalPartSec)
    let configLastDuration = BehaviorRelay<String?>(value: String(AppDelegate.settings.syncConfig.lastDuration))
    let configLastTime = BehaviorRelay<String?>(value: AppDelegate.settings.syncConfig.lastTime.toString(withFormat: "yyyy-MM-dd HH:mm:ss")) //TODO: localization
    let configReconnectMethod = BehaviorRelay<ReconnectMethod>(value: AppDelegate.settings.syncConfig.reconnectMethod)

    let saveCommand = PublishRelay<Void>()

    required init() {
        super.init()
        title.val = "Nav2"

        saveCommand += {
            self.send(message: .msgBox(title: "Display ViewModel values", message: "exampleVar: \(self.exampleVar.val), baseVar: \(self.rememberMe.val)"))

            AppDelegate.settings.exampleVar = self.exampleVar.val!

            AppDelegate.settings.rememberMe = self.rememberMe.val
            AppDelegate.settings.autoLoginEnabled = self.autoLoginEnabled.val

            //AppDelegate.settings.userAuthContext = self.userAuthContext.val!

            AppDelegate.settings.syncConfig = SynchronizationConfig(
                    automatic: self.configAutomatic.val,
                    lastTime: self.configLastTime.val!.toDate(withFormat: "yyyy-MM-dd HH:mm:ss") ?? Date(),
                    lastDuration: Int(self.configLastDuration.val!) ?? -1,
                    intervalFullSec: self.configIntervalFullSec.val,
                    intervalPartSec: self.configIntervalPartSec.val,
                    reconnectMethod: self.configReconnectMethod.val
            )
        } => self.disposeBag
    }
}
