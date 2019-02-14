//
// Created by Papp Imre on 2019-02-13.
// Copyright (c) 2019 CocoaPods. All rights reserved.
//

import NMDEF_Base
import RxCocoa

class MenuListViewModel: BaseViewModel {
    let menuItems = BehaviorRelay<[MenuItemViewModel]>(value: [MenuItemViewModel]())
    let selectMenuCommand = PublishRelay<MenuItemViewModel>()

    required init() {
        super.init()
        title.val = "Menu"

        menuItems.val = [
            MenuItemViewModel(MenuItemModel(id: Menu.TabBarController, name: "Tabbar example")),
            MenuItemViewModel(MenuItemModel(id: Menu.NavigationController, name: "Navigation example")),
        ]

        selectMenuCommand += { menu in
            switch menu.id {
            case .TabBarController: self.next(step: AppStep.tabbarExample)
            case .NavigationController: self.next(step: AppStep.navigationExample)
            }
        } => disposeBag
    }
}