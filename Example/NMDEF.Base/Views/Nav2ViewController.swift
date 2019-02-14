//
// Created by Papp Imre on 2019-02-14.
// Copyright (c) 2019 CocoaPods. All rights reserved.
//

import NMDEF_Base

class Nav2ViewController: BaseViewController<Nav2ViewModel> {
    override func initialize() {
        rx.viewCouldBind += { _ in
        }
    }
}
