//
// Created by Papp Imre on 2019-02-14.
// Copyright (c) 2019 CocoaPods. All rights reserved.
//

import NMDEF_Base
import RxCocoa

class Tab2ViewModel: BaseViewModel {
    let nextCommand = PublishRelay<Void>()

    required init() {
        super.init()
        title.val = "Tab2"

        nextCommand += {
            self.next(step: AppStep.tab2nav1)
        } => self.disposeBag
    }
}