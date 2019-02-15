//
// Created by Papp Imre on 2019-02-15.
//

import UIKit

public protocol HasRootController {
    associatedtype RootControllerType: UIViewController

    var rootViewController: RootControllerType { get }
    func create() -> RootControllerType
    func configure(view vc: RootControllerType)
}