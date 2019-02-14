//
// Created by Papp Imre on 2019-02-14.
// Copyright (c) 2019 CocoaPods. All rights reserved.
//

import NMDEF_Base
import RxFlow

class NavigationFlow: BaseFlow, FlowWithNavigationRoot {
    func navigate(to step: Step) -> NextFlowItems {
        guard let step = step as? AppStep else {
            return .none
        }
        switch step {
        case .nav1: return pushNavigation(to: Nav1ViewController.self)
        case .nav2: return pushNavigation(to: Nav2ViewController.self)
        case .menu: return .end(withStepForParentFlow: AppStep.dismiss)
        case .dismiss: return dismiss()
        default: return .none
        }
    }
}