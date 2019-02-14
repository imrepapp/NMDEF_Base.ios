//
// Created by Papp Imre on 2019-01-19.
// Copyright (c) 2019 XAPT Kft. All rights reserved.
//

import UIKit
import RxFlow
import Reusable

private var navigationContext: UInt8 = 0

public protocol FlowWithNavigationRoot: Flow, HasRootController where RootControllerType == UINavigationController {
    func create() -> UINavigationController
}

public extension FlowWithNavigationRoot where Self: BaseFlow {
    var root: Presentable {
        return self.rootViewController
    }

    func create() -> UINavigationController {
        return UINavigationController()
    }

    public var rootViewController: UINavigationController {
        return self.synchronized {
            if let nav = objc_getAssociatedObject(self, &navigationContext) as? UINavigationController {
                return nav
            }
            let newNav = self.create()
            objc_setAssociatedObject(self, &navigationContext, newNav, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
            return newNav
        }
    }

    public func pushNavigation<TViewController>(to viewControllerClass: TViewController.Type, animated: Bool = true, params: Parameters? = nil) -> NextFlowItems
            where TViewController: UIViewController & BaseViewControllerProtocol, TViewController.TViewModel: Stepper {
        let vc = viewControllerClass.instantiate()
        if (params != nil) {
            vc.viewModel.instantiate(with: params!)
        }
        self.rootViewController.pushViewController(vc, animated: animated)
        return .one(flowItem: NextFlowItem(nextPresentable: vc, nextStepper: vc.viewModel))
    }
}

public extension FlowWithNavigationRoot where Self: BaseFlow & StoryboardSceneBased {
    func create() -> UINavigationController {
        let navigationController = Self.sceneStoryboard.instantiateViewController(withIdentifier: Self.sceneIdentifier) as! UINavigationController
        if (navigationController.viewControllers.count > 0) {
            print("WARNING: \(Self.sceneIdentifier) has relationship segue, first view controller will be initialized twice.")
        }
        let vc = UIViewController()
        vc.view.backgroundColor = UIColor.white
        navigationController.viewControllers = [vc]
        return navigationController
    }
}
