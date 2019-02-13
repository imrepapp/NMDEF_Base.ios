//
// Created by Papp Imre on 2019-02-13.
// Copyright (c) 2019 CocoaPods. All rights reserved.
//

import NMDEF_Base

class MenuViewController: BaseViewController<MenuViewModel> {
    override func initialize() {
        rx.viewDidLoad += { _ in
            self.navigationItem.hidesBackButton = true
        } => self.disposeBag

        rx.viewCouldBind += { _ in
        } => self.disposeBag
    }
}