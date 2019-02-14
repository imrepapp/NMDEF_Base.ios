//
// Created by Papp Imre on 2019-02-14.
// Copyright (c) 2019 CocoaPods. All rights reserved.
//

import NMDEF_Base
import RxFlow

class TabBarFlow: BaseFlow, FlowWithTabBarRoot {
    var tabs: [Flow] = []

    func navigate(to step: Step) -> NextFlowItems {
        guard let step = step as? AppStep else {
            return .none
        }
        switch step {
        default: return .none
        }
    }
}

/*
public enum TestStep: Step {
    case tab1Initial
    case tab2Initial
}

class TestViewModel : BaseViewModel {

}

class TestUIViewController: BaseViewController<TestViewModel> {

}

class Flow1: BaseFlow, FlowWithNavigationRoot {
    func navigate(to step: Step) -> NextFlowItems {
        guard let step = step as? TestStep else {
            return .none
        }

        switch step {
        case .tab1Initial: return pushNavigation(to: TestUIViewController.self)
        default: return .none
        }
    }
}

class Flow2: BaseFlow, FlowWithNavigationRoot {
    func navigate(to step: Step) -> NextFlowItems {
        guard let step = step as? TestStep else {
            return .none
        }

        switch step {
        case .tab2Initial: return pushNavigation(to: TestUIViewController.self)
        default: return .none
        }
    }
}
*/