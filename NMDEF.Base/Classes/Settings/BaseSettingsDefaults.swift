//
// Created by Papp Imre on 2019-02-21.
// Copyright (c) 2019 CocoaPods. All rights reserved.
//

struct BaseSettingsDefaults: BaseSettingsVariables {
    //var apiUrl: String = "https://mobile-demo.xapt.com/env/dev/0457/nmdef/rental"
    var apiUrl: String = "https://naxtmobileapi.azurewebsites.net/rental"
    var userAuthContext: UserAuthContext? = nil
    var autoLoginEnabled: Bool = false
    var rememberMe: Bool = false
    var syncConfig: SynchronizationConfig = SynchronizationConfig(
            automatic: true,
            lastTime: Date.distantPast,
            lastDuration: 0,
            intervalFullSec: 60,
            intervalPartSec: 5,
            reconnectMethod: ReconnectMethod.ALWAYS
    )
}
