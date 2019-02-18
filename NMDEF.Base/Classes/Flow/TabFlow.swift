//
// Created by Papp Imre on 2019-02-14.
//

import RxFlow
import UIKit

open class TabFlow: BaseFlow {
    private var _tabBarItem: UITabBarItem? = nil

    public var initialStep: Step

    var tabBarItem: UITabBarItem {
        get {
            return _tabBarItem ?? UITabBarItem(title: "N/A", image: nil, selectedImage: nil)
        }
        set {
            _tabBarItem = newValue
        }
    }

    required public init() {
        fatalError("Can't call the init method without parameters.")
    }

    required public init(initialStep: Step) {
        self.initialStep = initialStep
        super.init()
    }
}

public extension HasRootController where Self: TabFlow {
    func configure(view vc: RootControllerType) {
        vc.tabBarItem = self.tabBarItem
    }
}