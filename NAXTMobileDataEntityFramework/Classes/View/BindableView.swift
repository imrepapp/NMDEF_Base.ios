//
// Created by Papp Imre on 2019-01-20.
// Copyright (c) 2019 XAPT Kft. All rights reserved.
//

import RxFlow

public protocol BindableView: HasDisposeBag {
    associatedtype Model: ViewModel
    func bind(_ model: Model)
}
