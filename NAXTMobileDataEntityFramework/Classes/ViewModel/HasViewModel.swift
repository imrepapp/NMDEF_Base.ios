//
//  HasViewModel.swift
//  NAXT Mobile Data Entity Framework
//
//  Created by Papp Imre on 2019. 01. 19..
//  Copyright © 2019. XAPT Kft. All rights reserved.
//

import RxFlow

public protocol HasViewModelWithoutType {
    var viewModelWithoutType: ViewModel { get }
}

public protocol HasViewModel: HasViewModelWithoutType {
    associatedtype TViewModel: ViewModel

    var viewModel: TViewModel { get set }
}

extension HasViewModel {
    public var viewModelWithoutType: ViewModel {
        return viewModel
    }
}
