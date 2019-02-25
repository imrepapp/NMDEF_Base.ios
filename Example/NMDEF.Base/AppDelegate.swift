//
//  AppDelegate.swift
//  NMDEF.Base
//
//  Created by Papp Imre on 02/13/2019.
//  Copyright (c) 2019 Papp Imre. All rights reserved.
//

import UIKit
import NMDEF_Base

@UIApplicationMain
class AppDelegate: BaseAppDelegate<ExampleSettings, ExampleApi> {

    override init() {
        super.init(mainFlow: MainFlow(), initialStep: AppStep.menu)

        container.register(UserAuthServiceProtocol.self) { _ in
            UserAuthService()
        }.inObjectScope(.container)

        container.register(BaseSettings.self) { _ in
            ExampleSettings()
        }.inObjectScope(.container)

        container.register(BaseApi.self) { _ in
            ExampleApi()
        }.inObjectScope(.container)
    }
}
