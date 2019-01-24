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
import Reusable

public protocol BaseViewControllerProtocol: BindableViewController, HasViewModel, StoryboardSceneBased {
}

open class BaseViewController<TViewModel: BaseViewModel>: UIViewController, BaseViewControllerProtocol {
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
        } => self.disposeBag
    }

    open func initialize() {
    }

    public var _viewCouldBind = PublishSubject<Void>()

    func setupBindings() {
        self.viewModel.title --> self.navigationItem.rx.title => self.disposeBag

        self.viewModel.presenterMessage += { [weak self] msg in
            switch (msg) {
            case .alert(let title, let message):
                let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
                alertController.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
                self?.present(alertController, animated: true)
                break
            default: print("\(msg) has not been implemented")
            }
        } => self.disposeBag

        self._viewCouldBind.onNext(())
    }

    open override func shouldPerformSegue(withIdentifier identifier: String, sender: Any?) -> Bool {
        return false
    }
}
