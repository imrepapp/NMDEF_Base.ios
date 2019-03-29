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
import RxReachability
import Reachability

public enum Message {
    case msgBox(title: String, message: String)
    case alert(config: AlertConfig)
}

public struct AlertConfig {
    var title: String?
    var message: String?
    var style: UIAlertController.Style = .alert
    var actions: [UIAlertAction] = []

    public init(title: String, message: String) {
        self.init(title: title, message: message, actions: [UIAlertAction(title: "Ok", style: .default)])
    }

    public init(title: String, message: String, actions: [UIAlertAction]) {
        self.title = title
        self.message = message
        self.actions = actions
    }
}

open class BaseViewModel: ViewModel, Stepper, HasDisposeBag, ReactiveCompatible {
    public let title = BehaviorRelay<String?>(value: nil)
    public var isLoading = BehaviorRelay<Bool>(value: false)
    let presenterMessage = PublishRelay<Message>()
    let goBackMessage = PublishRelay<Void>()

    public var reachability: Reachability?

    required public init() {
    }

    public func initReachabilityNotifier(){
        try? reachability?.startNotifier()
        bindReachability()
    }

    public func stopReachabilityNotifier(){
        reachability?.stopNotifier()
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

    private func bindReachability() {
        reachability?.rx.reachabilityChanged
                .subscribe(onNext: { reachability in
                    print("Reachability changed: \(reachability.connection)")
                })
                .disposed(by: disposeBag)

        reachability?.rx.status
                .subscribe(onNext: {status in
                    print("Reachability status changed: \(status)")
                })
                .disposed(by: disposeBag)

        reachability?.rx.isReachable
                .subscribe(onNext: {isReachable in
                    print("Is reachable: \(isReachable)")
                })
                .disposed(by: disposeBag)

        reachability?.rx.isConnected
                .subscribe(onNext: {
                    print("Is connected")
                })
                .disposed(by: disposeBag)

        reachability?.rx.isDisconnected
                .subscribe(onNext: {
                    print("Is disconnected")
                })
                .disposed(by: disposeBag)
    }
}