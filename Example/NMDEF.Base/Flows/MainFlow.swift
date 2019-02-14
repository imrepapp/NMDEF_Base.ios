//
// Created by Papp Imre on 2019-01-19.
// Copyright (c) 2019 XAPT Kft. All rights reserved.
//

import RxFlow
import NMDEF_Base
import Reusable

class MainFlow: BaseFlow, FlowWithSinglePageRoot {
    typealias RootControllerType = MenuListViewController

    func navigate(to step: Step) -> NextFlowItems {
        guard let step = step as? AppStep else {
            return .none
        }
        switch step {
        case .menu: return show()
        case .navigationExample: return start(flow: NavigationFlow(), step: AppStep.nav1)
        case .tabbarExample: return start(flow: TabBarFlow(), step: AppStep.tab1)
        case .dismiss: return dismiss()
        default: return .none
        }
    }
}
