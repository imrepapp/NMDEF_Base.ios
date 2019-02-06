//
//  BaseViewModel.swift
//  NAXT Mobile Data Entity Framework
//
//  Created by Papp Imre on 2019. 01. 17..
//  Copyright © 2019. XAPT Kft. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa
import RxFlow

public enum Message {
    case alert(title: String, message: String)
}

open class BaseViewModel: ViewModel, Stepper, HasDisposeBag {
    public let title = BehaviorRelay<String?>(value: nil)
    let presenterMessage = PublishRelay<Message>()
    let goBackMessage = PublishRelay<Void>()

    required public init() {
    }

    public func send(message: Message) {
        self.presenterMessage.accept(message)
    }

    public func next(step: Step) {
        self.step.accept(step)
    }

    open func instantiate(with params: Parameters) {
        print("NMDEF: unused parameters (\(params)) in \(self) class.")
    }
}
