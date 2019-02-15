//
// Created by Papp Imre on 2019-02-13.
// Copyright (c) 2019 CocoaPods. All rights reserved.
//

import RxFlow

enum AppStep: Step {
    //Global
    case menu
    case dismiss

    //NavigationFlow
    case navigationExample
    case nav1
    case nav2

    //TabBarFlow
    case tabbarExample
    case tab1
    case tab2
}
