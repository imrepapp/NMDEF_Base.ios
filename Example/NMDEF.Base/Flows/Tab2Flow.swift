//
// Created by Papp Imre on 2019-02-15.
// Copyright (c) 2019 CocoaPods. All rights reserved.
//

import NMDEF_Base
import RxFlow
import Reusable

class Tab2Flow: TabFlow, FlowWithNavigationRoot, StoryboardSceneBased {
    static var sceneIdentifier: String {
        return "Tab2Navigation"
    }

    func navigate(to step: Step) -> NextFlowItems {
        guard let step = step as? AppStep else {
            return .none
        }

        switch step {
        case .tab2: return pushNavigation(to: Tab2ViewController.self)
        case .tab2nav1: return pushNavigation(to: Nav3ViewController.self)
        default: return .none
        }
    }
}