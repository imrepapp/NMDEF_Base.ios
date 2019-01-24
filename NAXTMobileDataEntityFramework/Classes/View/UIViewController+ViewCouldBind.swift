//
//  UIViewController+ViewCouldBind.swift
//  NAXT Mobile Data Entity Framework
//
//  Created by Papp Imre on 2019. 01. 19..
//  Copyright © 2019. XAPT Kft. All rights reserved.
//

import RxSwift
import RxCocoa

public protocol BindableViewController: AnyObject {
    var _viewCouldBind: PublishSubject<Void> { get set }
}

public extension Reactive where Base: UIViewController & BindableViewController {
    public var viewCouldBind: ControlEvent<Void> {
        return ControlEvent(events: self.base._viewCouldBind)
    }
}
