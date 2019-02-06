//
// Created by Papp Imre on 2019-01-20.
// Copyright (c) 2019 XAPT Kft. All rights reserved.
//

import UIKit
import RxFlow

fileprivate var callerViewModelContext: UInt8 = 0

public protocol Parameters {
}

public protocol ViewModel: Synchronizable {
    func instantiate(with params: Parameters)

    var caller: ViewModel? { get set }
}

extension ViewModel {
    public var caller: ViewModel? {
        get {
            return self.synchronized {
                return objc_getAssociatedObject(self, &callerViewModelContext) as? ViewModel
            }
        }

        set {
            self.synchronized {
                objc_setAssociatedObject(self, &callerViewModelContext, newValue, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
            }
        }
    }

    mutating public func setCaller(_ caller: UIViewController) {
        if let vcWithViewModel = caller as? HasViewModelWithoutType {
            self.caller = vcWithViewModel.viewModelWithoutType
        }
    }
}