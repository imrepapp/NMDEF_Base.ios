//
// Created by Papp Imre on 2019-02-14.
// Copyright (c) 2019 CocoaPods. All rights reserved.
//

import NMDEF_Base
import RxCocoa

class Tab3ViewModel: BaseViewModel {
    let menuCommand = PublishRelay<Void>()

    required init() {
        super.init()
        title.val = "Tab3"

        menuCommand += {
            self.next(step: AppStep.menu)
        } => self.disposeBag
    }
}
