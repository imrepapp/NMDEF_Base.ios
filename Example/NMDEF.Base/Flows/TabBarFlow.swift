//
// Created by Papp Imre on 2019-02-14.
// Copyright (c) 2019 CocoaPods. All rights reserved.
//

import NMDEF_Base
import RxFlow

class TabBarFlow: BaseFlow, FlowWithTabBarRoot {
    typealias Tabs = ExampleTabs

    var tabFlows: [TabFlow] {
        return [
            Tab1Flow(initialStep: AppStep.tab1),
            Tab2Flow(initialStep: AppStep.tab2)
        ]
    }
}