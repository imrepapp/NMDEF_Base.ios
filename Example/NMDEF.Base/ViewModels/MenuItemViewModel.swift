//
// Created by Papp Imre on 2019-02-14.
// Copyright (c) 2019 CocoaPods. All rights reserved.
//

import NMDEF_Base
import RxCocoa

class MenuItemViewModel : SimpleViewModel {
    let id: Menu
    let name = BehaviorRelay<String?>(value: nil)

    init(_ model: MenuItemModel) {
        self.id = model.id
        self.name.val = model.name
    }

    func asModel() -> MenuItemModel {
        fatalError("asModel() has not been implemented")
    }
}
