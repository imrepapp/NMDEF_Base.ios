//
// Created by Papp Imre on 2019-01-19.
// Copyright (c) 2019 XAPT Kft. All rights reserved.
//

import UIKit
import RxFlow
import Reusable

private var tabBarContext: UInt8 = 0
private var tabsContext: UInt8 = 0

public protocol FlowWithTabBarRoot: Flow, HasRootController where RootControllerType == UITabBarController {
    associatedtype Tabs: TabBarItems
    var tabFlows: [TabFlow] { get }
}

public extension FlowWithTabBarRoot where Self: BaseFlow {
    private var _tabFlows: [TabFlow] {
        get {
            return self.synchronized {
                if let flows = objc_getAssociatedObject(self, &tabsContext) as? [TabFlow] {
                    return flows
                }
                return []
            }
        }
        set {
            self.synchronized {
                objc_setAssociatedObject(self, &tabsContext, newValue, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
            }
        }
    }

    var root: Presentable {
        return self.rootViewController
    }

    func create() -> UITabBarController {
        initializeTabs()
        let root = UITabBarController()
        configure(view: root)
        return root
    }

    private func initializeTabs() {
        guard Tabs.items.count == tabFlows.count else {
            fatalError("Count mismatch, flows count does not match the count of tabItems")
        }
        //must copy tab flows form a read-only variable to a stored variable to able to add TabBarItem to each flow
        _tabFlows = []
        for f: TabFlow in tabFlows {
            f.tabBarItem = Tabs.items[f.initialStep.toString()]!
            _tabFlows.append(f)
        }
    }

    func navigate(to step: Step) -> NextFlowItems {
        var selectedIndex = 0
        var nextFlowItems: [NextFlowItem] = []

        for i: Int in 0..<_tabFlows.count {
            if step.toString() == _tabFlows[i].initialStep.toString() {
                selectedIndex = i
            }
            nextFlowItems.append(NextFlowItem(nextPresentable: _tabFlows[i] as! Flow, nextStepper: OneStepper(withSingleStep: _tabFlows[i].initialStep)))
        }

        Flows.whenReady(flows: _tabFlows as! [Flow], block: { [unowned self] (tabRoots: [UIViewController]) in
            self.rootViewController.setViewControllers(tabRoots, animated: false)
            self.rootViewController.selectedIndex = selectedIndex
        })

        return .multiple(flowItems: nextFlowItems)
    }

    public var rootViewController: UITabBarController {
        return self.synchronized {
            if let tabBar = objc_getAssociatedObject(self, &tabBarContext) as? UITabBarController {
                return tabBar
            }
            let newTabBar = self.create()
            objc_setAssociatedObject(self, &tabBarContext, newTabBar, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
            return newTabBar
        }
    }
}

public extension FlowWithTabBarRoot where Self: BaseFlow & StoryboardSceneBased {
    func create() -> UITabBarController {
        initializeTabs()
        let tabBarController = Self.sceneStoryboard.instantiateViewController(withIdentifier: Self.sceneIdentifier) as! UITabBarController
        configure(view: tabBarController)
        return tabBarController
    }
}
