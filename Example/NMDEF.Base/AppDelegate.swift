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
class AppDelegate: BaseAppDelegate<ExampleApi, ExampleSettingsProtocol> {
    public static var settings: ExampleSettings {
        return BaseAppDelegate.settings as! ExampleSettings
    }


    override init() {
        super.init(mainFlow: MainFlow(), initialStep: AppStep.menu)

        //TODO: register singelton for services

    }
}
