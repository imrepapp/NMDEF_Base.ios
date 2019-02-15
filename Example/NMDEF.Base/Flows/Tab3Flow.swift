//
// Created by Papp Imre on 2019-02-15.
// Copyright (c) 2019 CocoaPods. All rights reserved.
//

import NMDEF_Base
import RxFlow

class Tab3Flow: TabFlow, FlowWithSinglePageRoot {
    typealias RootControllerType = Tab3ViewController

    func navigate(to step: Step) -> NextFlowItems {
        guard let step = step as? AppStep else {
            return .none
        }

        switch step {
        case .tab3: return show()
        case .menu: return .end(withStepForParentFlow: TabBarDismissStep())
        default: return .none
        }
    }
}
