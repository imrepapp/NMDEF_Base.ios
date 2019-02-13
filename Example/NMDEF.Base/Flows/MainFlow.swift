//
// Created by Papp Imre on 2019-01-19.
// Copyright (c) 2019 XAPT Kft. All rights reserved.
//

import RxFlow
import NMDEF_Base
import Reusable

class MainFlow: BaseFlow, FlowWithNavigationRoot, StoryboardSceneBased {
    static var sceneStoryboard: UIStoryboard {
        return UIStoryboard(name: "Main", bundle: nil)
    }
    static var sceneIdentifier: String {
        return "MainNavigation"
    }

    func navigate(to step: Step) -> NextFlowItems {
        guard let step = step as? AppStep else {
            return .none
        }
        switch step {
        case .menu: return pushNavigation(to: MenuViewController.self)
        default: return .none
        }
    }
}
