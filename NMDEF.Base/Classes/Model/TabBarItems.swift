//
// Created by Papp Imre on 2019-02-15.
//

import UIKit
import RxFlow

public protocol TabBarItems {
    static var items: [String: UITabBarItem] { get }
}
