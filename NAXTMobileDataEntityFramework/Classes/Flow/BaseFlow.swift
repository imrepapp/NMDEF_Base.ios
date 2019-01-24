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
    public static var store = [String: [String: Any]]()

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

public protocol Instantiateable {
    func instantiate(_ rootFlowItem: NextFlowItem) -> NextFlowItems
}

public protocol HasRootController: Instantiateable {
    associatedtype RootControllerType: UIViewController
    var rootViewController: RootControllerType { get }
}

public extension HasRootController where Self: BaseFlow {
    func start(flow: Flow & Instantiateable, step: Step,
               animated: Bool = true, transition: UIModalTransitionStyle = .coverVertical, presentation: UIModalPresentationStyle = .fullScreen
    ) -> NextFlowItems {
        Flows.whenReady(flow1: flow, block: { [unowned self] (root) in
            self.presentModal(self.rootViewController, root, animated: animated, transition: transition, presentation: presentation)
        })

        return flow.instantiate(NextFlowItem(nextPresentable: flow, nextStepper: OneStepper(withSingleStep: step)))
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
