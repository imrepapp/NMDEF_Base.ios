//
// Created by Papp Imre on 2019-01-20.
// Copyright (c) 2019 XAPT Kft. All rights reserved.
//

import RxFlow

public protocol SimpleViewModel: ViewModel, HasDisposeBag {
    associatedtype TModel: BaseModel

    func asModel() -> TModel
}

extension SimpleViewModel {
    public var caller: ViewModel? { return nil }

    public func instantiate(with params: Parameters) {
    }
}