//
// Created by Papp Imre on 2019-01-21.
// Copyright (c) 2019 XAPT Kft. All rights reserved.
//

import UIKit

public extension UITableView {
    func deselectSelectedRow(animated: Bool = false) {
        if let idx = self.indexPathForSelectedRow {
            self.deselectRow(at: idx, animated: animated)
        }
    }
}
