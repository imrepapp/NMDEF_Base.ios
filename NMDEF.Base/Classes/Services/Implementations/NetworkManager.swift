//
// Created by Róbert PAPP on 2019-04-01.
//

import Reachability
import RxReachability
import RxSwift
import RxCocoa

public class NetworkManager: NetworkManagerProtocol {

    var reachability: Reachability!
    let disposeBag = DisposeBag()
    public var isNetworkAvailable = BehaviorRelay<Bool>(value: false)
    public var networkIsReachable: Bool = false

    var currentStatus: Reachability.Connection = Reachability.Connection.none

    public init() {
        // Initialise reachability
        reachability = Reachability()!
    }

    public func initReachabilityNotifier() {
        try? reachability?.startNotifier()
    }

    public func stopReachabilityNotifier() {
        reachability?.stopNotifier()
    }

    // Network is reachable
    public func getcurrentNetworkStatus() -> Bool {
        return networkIsReachable
    }

    // Current network status
    public func getActualConnection() -> Reachability.Connection {
        return currentStatus
    }

    public func bindReachability() {
        reachability?.rx.reachabilityChanged
                .subscribe(onNext: { reachability in
                    print("Reachability changed: \(reachability.connection)")

                })
                .disposed(by: disposeBag)

        reachability?.rx.status
                .subscribe(onNext: { status in
                    print("Reachability status changed: \(status)")
                })
                .disposed(by: disposeBag)

        reachability?.rx.isReachable
                .subscribe(onNext: {isReachable in
                    print("IsReachable: \(isReachable)")
                })
                .disposed(by: disposeBag)

        reachability?.rx.isConnected
                .subscribe(onNext: {
                    self.isNetworkAvailable.val = true
                    print("Connected network")
                })
                .disposed(by: disposeBag)

        reachability?.rx.isDisconnected
                .subscribe(onNext: {
                    self.isNetworkAvailable.val = false
                    print("Disconnected network")
                })
                .disposed(by: disposeBag)
    }
}

