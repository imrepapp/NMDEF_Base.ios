//
// Created by Róbert PAPP on 2019-04-01.
//

import Reachability
import RxReachability
import RxSwift

public class NetworkManager: NetworkManagerProtocol {

    var reachability: Reachability!
    let disposeBag = DisposeBag()

    var networkIsReachable: Bool = false

    var currectStatus: Reachability.Connection = Reachability.Connection.none

    public init() {
        // Initialise reachability
        reachability = Reachability()!
        initReachabilityNotifier()
    }

    public func initReachabilityNotifier() {
        try? reachability?.startNotifier()
        bindReachability()
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
        return currectStatus
    }

    func bindReachability() {
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
                    self.networkIsReachable = isReachable
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

