//
// Created by Papp Imre on 2019-01-17.
// Copyright (c) 2019 XAPT Kft. All rights reserved.
//

import RxSwift
import RxCocoa

extension BehaviorRelay {
    public var val: Element {
        get {
            return self.value
        }
        set {
            self.accept(newValue)
        }
    }
}

extension ComputedBehaviorRelay {
    public var val: Element { return self.value }
}
