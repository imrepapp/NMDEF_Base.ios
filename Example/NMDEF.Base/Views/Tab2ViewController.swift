//
// Created by Papp Imre on 2019-02-14.
// Copyright (c) 2019 CocoaPods. All rights reserved.
//

import NMDEF_Base

class Tab2ViewController: BaseViewController<Tab2ViewModel> {
    override func initialize() {
        rx.viewCouldBind += { _ in
        } => self.disposeBag
    }
}
