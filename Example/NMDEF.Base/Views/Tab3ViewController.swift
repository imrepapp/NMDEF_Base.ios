//
// Created by Papp Imre on 2019-02-14.
// Copyright (c) 2019 CocoaPods. All rights reserved.
//

import NMDEF_Base

class Tab3ViewController: BaseViewController<Tab3ViewModel> {
    @IBOutlet weak var menuButton: UIButton!

    override func initialize() {
        rx.viewCouldBind += { _ in
            self.menuButton.rx.tap --> self.viewModel.menuCommand => self.disposeBag
        } => self.disposeBag
    }
}
