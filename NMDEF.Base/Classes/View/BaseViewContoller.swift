//
//  BaseViewContoller.swift
//  NAXT Mobile Data Entity Framework
//
//  Created by Papp Imre on 2019. 01. 17..
//  Copyright © 2019. XAPT Kft. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa
import RxFlow
import RxViewController
import RxKeyboard
import Reusable
import UserNotifications

public protocol BaseViewControllerProtocol: BindableViewController, HasViewModel, StoryboardSceneBased {
}

open class BaseViewController<TViewModel: BaseViewModel>: UIViewController, BaseViewControllerProtocol {
    @IBOutlet public weak var scrollView: UIScrollView!

    private var _scrollViewOrigY: CGFloat = 0

    public static var sceneStoryboard: UIStoryboard {
        return UIStoryboard(name: "Main", bundle: nil)
    }

    public static var sceneIdentifier: String {
        return String(describing: self).replacingOccurrences(of: "ViewController", with: "Scene")
    }

    public var viewModel: TViewModel

    required public init(coder: NSCoder) {
        self.viewModel = TViewModel.init()
        super.init(coder: coder)!

        self.initialize()

        self.rx.viewDidLoad += { _ in
            self.setupBindings()
            self.viewModel.rx.viewCreated.onNext(())

            // #1.1 - Create "the notification's category value--its type."
            let noNetworkIsAvailableNotifCategory = UNNotificationCategory(identifier: "noNetworkIsAvailableNotification", actions: [], intentIdentifiers: [], options: [])
            // #1.2 - Register the notification type.
            UNUserNotificationCenter.current().setNotificationCategories([noNetworkIsAvailableNotifCategory])

            if let sv = self.scrollView {
                self._scrollViewOrigY = self.scrollView.contentOffset.y
            }

            RxKeyboard.instance.visibleHeight
                    .drive(onNext: { [weak self] keyboardVisibleHeight in
                        guard let `self` = self else {
                            return
                        }

                        guard let sv = self.scrollView else {
                            return
                        }

                        if keyboardVisibleHeight > 0 {
                            self.scrollView.contentOffset.y += keyboardVisibleHeight
                        } else {
                            self.scrollView.contentOffset.y = self._scrollViewOrigY
                        }
                    })
                    .disposed(by: self.disposeBag)
        } => self.disposeBag

        self.rx.viewWillAppear += {
            _ in
            self.viewModel.rx.viewAppearing.onNext(())
            BaseAppDelegate.networkManager.initReachabilityNotifier()
        } => self.disposeBag

        self.rx.viewDidAppear += {
            _ in
            self.viewModel.rx.viewAppeared.onNext(())
        } => self.disposeBag

        self.rx.viewWillDisappear += {
            _ in
            self.viewModel.rx.viewDisappearing.onNext(())
            BaseAppDelegate.networkManager.stopReachabilityNotifier()
        } => self.disposeBag

        self.rx.viewDidDisappear += {
            _ in
            self.viewModel.rx.viewDisappeared.onNext(())
        } => self.disposeBag

        self.rx.isDismissing += {
            _ in
            self.viewModel.rx.viewDestroy.onNext(())
        } => self.disposeBag
    }

    open func initialize() {
    }

    public var _viewCouldBind = PublishSubject<Void>()

    func setupBindings() {
        self.viewModel.title --> self.navigationItem.rx.title => self.disposeBag

        self.viewModel.presenterMessage += { [weak self] msg in
            switch (msg) {
            case .alert(let config):
                self?._showAlert(config: config)
                break
            case .msgBox(let title, let message):
                self?._showAlert(config: AlertConfig(title: title, message: message))
                break

            }
        } => self.disposeBag

        self._viewCouldBind.onNext(())
    }

    private func _showAlert(config: AlertConfig) {
        let alertController = UIAlertController(title: config.title, message: config.message, preferredStyle: config.style)

        for var action in config.actions {
            alertController.addAction(action)
        }

        present(alertController, animated: true)
    }

    open override func shouldPerformSegue(withIdentifier identifier: String, sender: Any?) -> Bool {
        return false
    }
}
