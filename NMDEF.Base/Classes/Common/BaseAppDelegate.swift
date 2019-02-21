//
//  BaseAppDelegate.swift
//  NAXT Mobile Data Entity Framework
//
//  Created by Papp Imre on 2019. 01. 19..
//  Copyright © 2019. XAPT Kft. All rights reserved.
//


//print("\(type(of: self)).\(#function)")

import UIKit
import RxSwift
import RxFlow
import Swinject

open class BaseAppDelegate<TSettings: BaseSettings, TApi: BaseApi>: UIResponder, UIApplicationDelegate, HasDisposeBag {
    public static var settings: TSettings {
        return BaseAppDelegate.instance._settings as! TSettings
    }
    public static var api: TApi {
        return BaseAppDelegate.instance._api as! TApi
    }
    public static var instance: BaseAppDelegate {
        return UIApplication.shared.delegate as! BaseAppDelegate
    }
    public static var token: String {
        get {
            //it would be better if I can throw an error what is catchable
            guard BaseAppDelegate.instance._token != nil else {
                fatalError("No token")
            }
            return BaseAppDelegate.instance._token!
        }
        set {
            BaseAppDelegate.instance._token = newValue
        }
    }
    public var window: UIWindow?

    let coordinator = Coordinator()

    private lazy var _settings: BaseSettingsProtocol = {
        //TODO: DI: Resolve<TSettings>
        return BaseSettings()
    }()
    private lazy var _api: BaseApiProtocol = {
        //TODO: DI: Resolve<TApi>
        return BaseApi()
    }()

    public lazy var container: Container = {
        return Container()
    }()

    private let mainFlow: Flow
    private let initialStep: Step
    private var _token: String? = nil

    override public init() {
        fatalError("must use: init(mainFlow flow: Flow, initialStep step: Step)")
    }

    public init(mainFlow flow: Flow, initialStep step: Step) {
        self.mainFlow = flow
        self.initialStep = step

        super.init();
    }

    open func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        guard let w = self.window else {
            fatalError("There is no UIWindow")
        }

        #if DEBUG
        // listening for the coordination mechanism is not mandatory, but can be useful
        self.coordinator.rx.didNavigate += { (flow, step) in
            print("NMDEF: navigate to \(type(of: flow)).\(step)")
        } => self.disposeBag
        #endif

        Flows.whenReady(flow1: self.mainFlow, block: { [unowned w] (flowRoot) in
            w.rootViewController = flowRoot
        })

        self.coordinator.coordinate(flow: self.mainFlow, withStepper: OneStepper(withSingleStep: self.initialStep))

        return true
    }

    open func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
    }

    open func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    open func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
    }

    open func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    open func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }
}
