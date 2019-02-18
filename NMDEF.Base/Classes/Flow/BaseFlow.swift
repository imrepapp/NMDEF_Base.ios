//
//  BaseFlow.swift
//  NAXT Mobile Data Entity Framework
//
//  Created by Papp Imre on 2019. 01. 19..
//  Copyright © 2019. XAPT Kft. All rights reserved.
//

import RxFlow
import Reusable

open class BaseFlow {
    func presentModal(_ parent: UIViewController, _ child: UIViewController,
                      animated: Bool, transition: UIModalTransitionStyle, presentation: UIModalPresentationStyle) {
        child.modalTransitionStyle = transition
        child.modalPresentationStyle = presentation
        parent.present(child, animated: animated, completion: nil)
    }

    public func getNextPresentable(_ items: NextFlowItems) -> Presentable? {
        switch (items) {
        case .one(let flowItem): return flowItem.nextPresentable
        default: return nil
        }
    }

    required public init() {
    }
}

public extension HasRootController where Self: BaseFlow {
    func configure(view vc: RootControllerType) {
        //add your own configure method to the flow class with extension
    }

    func start(flow: Flow, step: Step,
               animated: Bool = true, transition: UIModalTransitionStyle = .coverVertical, presentation: UIModalPresentationStyle = .fullScreen
    ) -> NextFlowItems {
        Flows.whenReady(flow1: flow, block: { [unowned self] (newViewController) in
            self.presentModal(self.rootViewController, newViewController, animated: animated, transition: transition, presentation: presentation)
        })

        return .one(flowItem: NextFlowItem(nextPresentable: flow, nextStepper: OneStepper(withSingleStep: step)))
    }

    func modalNavigation<TViewController>(
            to viewControllerClass: TViewController.Type, params: Parameters? = nil,
            animated: Bool = true, transition: UIModalTransitionStyle = .coverVertical, presentation: UIModalPresentationStyle = .fullScreen
    ) -> NextFlowItems where TViewController: UIViewController & BaseViewControllerProtocol, TViewController.TViewModel: Stepper {
        var vc = viewControllerClass.instantiate()
        if (params != nil) {
            vc.viewModel.instantiate(with: params!)
        }
        let parent = self.rootViewController.presentedViewController ?? self.rootViewController

        vc.viewModel.setCaller(parent)

        self.presentModal(parent, vc, animated: animated, transition: transition, presentation: presentation)
        return .one(flowItem: NextFlowItem(nextPresentable: vc, nextStepper: vc.viewModel))
    }

    func dismiss(animated: Bool = true) -> NextFlowItems {
        if let viewController = self.rootViewController.presentedViewController {
            viewController.dismiss(animated: animated)
        }
        return .none
    }
}
