//
// Created by Papp Imre on 2019-02-14.
// Copyright (c) 2019 CocoaPods. All rights reserved.
//

import NMDEF_Base
import RxCocoa
import RxSwift

class Nav2ViewController: BaseViewController<Nav2ViewModel> {
    @IBOutlet weak var exampleVarField: UITextField!
    @IBOutlet weak var rememberMeSwitch: UISwitch!
    @IBOutlet weak var autoLoginSwitch: UISwitch!
    @IBOutlet weak var autoConfigSwitch: UISwitch!
    @IBOutlet weak var lastSyncTimeField: UITextField!
    @IBOutlet weak var lastDurationField: UITextField!
    

    @IBOutlet weak var saveButton: UIButton!
    
    override func initialize() {
        rx.viewCouldBind += { _ in
            self.exampleVarField.rx.text <-> self.viewModel.exampleVar => self.disposeBag

            self.rememberMeSwitch.rx.isOn <-> self.viewModel.rememberMe => self.disposeBag
            self.autoLoginSwitch.rx.isOn <-> self.viewModel.autoLoginEnabled => self.disposeBag
            self.autoConfigSwitch.rx.isOn <-> self.viewModel.configAutomatic => self.disposeBag
            self.lastSyncTimeField.rx.text <-> self.viewModel.configLastTime => self.disposeBag
            self.lastDurationField.rx.text <-> self.viewModel.configLastDuration => self.disposeBag

            
            self.saveButton.rx.tap --> self.viewModel.saveCommand => self.disposeBag
        } => self.disposeBag
    }
}
