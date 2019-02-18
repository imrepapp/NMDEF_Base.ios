//
// Created by Papp Imre on 2019-02-14.
//

import UIKit
import RxFlow

private var singlePageContext: UInt8 = 0

public protocol FlowWithSinglePageRoot: Flow, HasRootController where RootControllerType: BaseViewControllerProtocol {
}

public extension FlowWithSinglePageRoot where Self: BaseFlow, RootControllerType.TViewModel: Stepper {
    var root: Presentable {
        return self.rootViewController;
    }

    func create() -> RootControllerType {
        let root = RootControllerType.instantiate()
        configure(view: root)
        return root
    }

    var rootViewController: RootControllerType {
        return self.synchronized {
            if let page = objc_getAssociatedObject(self, &singlePageContext) as? RootControllerType {
                return page
            }
            let newPage = self.create()
            objc_setAssociatedObject(self, &singlePageContext, newPage, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
            return newPage
        }
    }

    func show() -> NextFlowItems {
        return .one(flowItem: NextFlowItem(nextPresentable: self.rootViewController, nextStepper: self.rootViewController.viewModel))
    }
}
