//
// Created by Papp Imre on 2019-02-26.
//

import RxCocoa
import RxSwift

private var viewCreatedContext: UInt8 = 1
private var viewAppearingContext: UInt8 = 2
private var viewAppearedContext: UInt8 = 3
private var viewDisappearingContext: UInt8 = 4
private var viewDisappearedContext: UInt8 = 5
private var viewDestroyContext: UInt8 = 6


public extension Reactive where Base: BaseViewModel {
    var viewCreated: PublishSubject<Void> {
        return register(&viewCreatedContext)
    }
    var viewAppearing: PublishSubject<Void> {
        return register(&viewAppearingContext)
    }
    var viewAppeared: PublishSubject<Void> {
        return register(&viewAppearedContext)
    }
    var viewDisappearing: PublishSubject<Void> {
        return register(&viewDisappearingContext)
    }
    var viewDisappeared: PublishSubject<Void> {
        return register(&viewDisappearedContext)
    }
    var viewDestroy: PublishSubject<Void> {
        return register(&viewDestroyContext)
    }

    func synchronized<T>(_ action: () -> T) -> T {
        objc_sync_enter(self.base)
        let result = action()
        objc_sync_exit(self.base)
        return result
    }

    func register(_ context: UnsafeRawPointer) -> PublishSubject<Void> {
        return self.synchronized {
            let subject: PublishSubject<Void>
            if let existingSubject = objc_getAssociatedObject(self.base, context) {
                subject = existingSubject as! PublishSubject<Void>
            } else {
                subject = PublishSubject<Void>()
                objc_setAssociatedObject(self.base, context, subject, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
            }
            return subject
        }
    }
}
