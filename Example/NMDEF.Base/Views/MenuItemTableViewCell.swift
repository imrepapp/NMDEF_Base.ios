//
// Created by Papp Imre on 2019-01-20.
// Copyright (c) 2019 XAPT Kft. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa
import NMDEF_Base

class MenuItemTableViewCell: UITableViewCell, BindableView {
    typealias Model = MenuItemViewModel

    @IBOutlet weak var nameLabel: UILabel!

    func bind(_ model: MenuItemViewModel) {
        model.name --> nameLabel.rx.text => disposeBag
    }
}