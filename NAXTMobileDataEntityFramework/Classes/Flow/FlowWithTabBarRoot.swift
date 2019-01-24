//
// Created by Papp Imre on 2019-01-19.
// Copyright (c) 2019 XAPT Kft. All rights reserved.
//

import UIKit
import Foundation
import RxFlow
import Reusable

private var tabBarContext: UInt8 = 0

public protocol FlowWithTabBarRoot: Flow, HasRootController where RootControllerType == UITabBarController {
    func create() -> UITabBarController
    var tabs: [Flow] { get }
}

/****/
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
/*****/

public extension FlowWithTabBarRoot where Self: BaseFlow {
    var tabs: [Flow] {
        return [Flow1(), Flow2()]
    }

    var root: Presentable {
        return self.rootViewController
    }

    func create() -> UITabBarController {
        return UITabBarController()
    }

    func instantiate(_ rootFlowItem: NextFlowItem) -> NextFlowItems {
        return .one(flowItem: rootFlowItem)
    }

    func lofasz() -> NextFlowItems {
        Flows.whenReady(flows: tabs, block: { [unowned self] (roots: [UINavigationController]) in
            for tab: UIViewController in roots {
                tab.tabBarItem = UITabBarItem(title: "TAB1", image: nil, selectedImage: nil)
                tab.title = tab.tabBarItem.title
            }
            self.rootViewController.setViewControllers(roots, animated: false)
        })

        return .multiple(flowItems: [
            NextFlowItem(nextPresentable: tabs[0], nextStepper: OneStepper(withSingleStep: TestStep.tab1Initial)),
            NextFlowItem(nextPresentable: tabs[1], nextStepper: OneStepper(withSingleStep: TestStep.tab2Initial))
        ])
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

public extension FlowWithTabBarRoot where Self: StoryboardSceneBased {
    func create() -> UITabBarController {
        let tabBarController = Self.sceneStoryboard.instantiateViewController(withIdentifier: Self.sceneIdentifier) as! UITabBarController
        let vc = UIViewController()
        vc.view.backgroundColor = UIColor.white
        tabBarController.viewControllers = [vc]
        return tabBarController
    }
}
