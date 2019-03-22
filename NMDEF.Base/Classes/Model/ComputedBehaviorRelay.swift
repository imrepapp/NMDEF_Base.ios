//
// Created by Attila AMBRUS on 2019-03-22.
//

import RxSwift

public class ComputedBehaviorRelay<Element>: ObservableType {
    public typealias E = Element

    private let _subject: BehaviorSubject<Element>
    private let _value: () -> Element

    /// Emits it to subscribers
    public func raise() {
        self._subject.onNext(_value())
    }

    /// Current value of behavior subject
    public var value: Element {
        return _value()
    }

    /// Initializes behavior relay with initial value.
    public init(value: @escaping () -> Element) {
        self._value = value
        self._subject = BehaviorSubject(value: _value())
    }

    /// Subscribes observer
    public func subscribe<O: ObserverType>(_ observer: O) -> Disposable where O.E == E {
        return self._subject.subscribe(observer)
    }

    /// - returns: Canonical interface for push style sequence
    public func asObservable() -> Observable<Element> {
        return self._subject.asObservable()
    }
}
