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
class AppDelegate : BaseAppDelegate {
    override init() {
        super.init(mainFlow: MainFlow(), initialStep: AppStep.menu)
    }
}
