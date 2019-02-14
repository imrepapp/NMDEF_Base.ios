//
// Created by Papp Imre on 2019-02-13.
// Copyright (c) 2019 CocoaPods. All rights reserved.
//

import NMDEF_Base

class MenuListViewController: BaseViewController<MenuListViewModel> {
    @IBOutlet weak var tableView: UITableView!

    override func initialize() {
        rx.viewCouldBind += { _ in
            self.viewModel.menuItems.bind(to: self.tableView.rx.items(cellIdentifier: "MenuItemCell", cellType: MenuItemTableViewCell.self)) {
                (_, item, cell) in
                item --> cell
            } => self.disposeBag

            self.tableView.rx.modelSelected(MenuItemViewModel.self) += { model in
                self.viewModel.selectMenuCommand.accept(model)
                self.tableView.deselectSelectedRow()
            } => self.disposeBag

        } => self.disposeBag
    }
}