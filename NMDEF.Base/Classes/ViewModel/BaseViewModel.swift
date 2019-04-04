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
import UserNotifications

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

    required public init() {
        BaseAppDelegate.networkManager.isNetworkAvailable += { isNetworkAvailable_ in
            if !isNetworkAvailable_ {
                self.send(message: .alert(config: AlertConfig(title: "No Network is available", message: "Your connection status changed to offline", actions: [
                    UIAlertAction(title: "Ok", style: .default, handler: { alert in
                    })])))

               self.showNoNetworkIsAvailableNetwork()
            }
        } => disposeBag
    }

    func showNoNetworkIsAvailableNetwork(){
        // find out what are the user's notification preferences
        UNUserNotificationCenter.current().getNotificationSettings { (settings) in

            // we're only going to create and schedule a notification
            // if the user has kept notifications authorized for this app
            guard settings.authorizationStatus == .authorized else { return }

            // create the content and style for the local notification
            let content = UNMutableNotificationContent()

            // #2.1 - "Assign a value to this property that matches the identifier
            // property of one of the UNNotificationCategory objects you
            // previously registered with your app."
            content.categoryIdentifier = "noNetworkIsAvailableNotification"

            // create the notification's content to be presented
            // to the user
            content.title = "No network is available!"
            content.subtitle = "No network is available, please check your WIFI/Cellular state"
            content.sound = UNNotificationSound.default()

            // #2.2 - create a "trigger condition that causes a notification
            // to be delivered after the specified amount of time elapses";
            // deliver after 10 seconds
            let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 10, repeats: false)

            // create a "request to schedule a local notification, which
            // includes the content of the notification and the trigger conditions for delivery"
            let uuidString = UUID().uuidString
            let request = UNNotificationRequest(identifier: uuidString, content: content, trigger: trigger)

            // "Upon calling this method, the system begins tracking the
            // trigger conditions associated with your request. When the
            // trigger condition is met, the system delivers your notification."
            UNUserNotificationCenter.current().add(request, withCompletionHandler: nil)

        } // end getNotificationSettings
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