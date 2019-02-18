//
// Created by Papp Imre on 2019-02-15.
// Copyright (c) 2019 CocoaPods. All rights reserved.
//

import UIKit
import NMDEF_Base

class ExampleTabs: TabBarItems {
    static var items: [String: UITabBarItem] = [
        AppStep.tab1.toString(): UITabBarItem(title: "TabBar1", image: nil, selectedImage: nil),
        AppStep.tab2.toString(): UITabBarItem(title: "TabBar2", image: nil, selectedImage: nil),
        AppStep.tab3.toString(): UITabBarItem(title: "TabBar3", image: nil, selectedImage: nil)
    ]
}
