//
// Created by Papp Imre on 2019-02-14.
// Copyright (c) 2019 CocoaPods. All rights reserved.
//

import NMDEF_Base
import UIKit

class Nav1ViewController: BaseViewController<Nav1ViewModel> {
    @IBOutlet weak var nextButton: UIBarButtonItem!
    @IBOutlet weak var menuButton: UIBarButtonItem!
    
    override func initialize() {
        rx.viewCouldBind += { _ in
            self.menuButton.rx.tap --> self.viewModel.menuCommand => self.disposeBag
            self.nextButton.rx.tap --> self.viewModel.nextCommand => self.disposeBag
        } => self.disposeBag
    }
}
