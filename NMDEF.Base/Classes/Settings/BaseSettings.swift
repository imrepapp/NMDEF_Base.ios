//
// Created by Papp Imre on 2019-02-19.
//

open class BaseSettings: BaseSettingsProtocol {
    private let defaults = BaseSettingsDefaults()

    open var apiUrl: String {
        fatalError("API url not defined.")
    }
    open var dataProviderUrl: String {
        fatalError("dataprovider url not defined.")
    }
    public var appName: String {
        return Bundle.main.object(forInfoDictionaryKey: "CFBundleDisplayName") as! String
    }
    open var splashMaxTimoutSec: Int {
        fatalError("max splash timeout is not defined.")
    }

    public var reactName: String? {
        if self.userAuthContext != nil && self.userAuthContext?.selectedConfig?.id != nil && self.userAuthContext?.hcmWorker != nil {
            return "NS\(self.userAuthContext?.selectedConfig?.id)-\(self.userAuthContext?.hcmWorker).react"
        }
        return nil
    }

    public var appVersion: String {
        let appVersion: String = Bundle.main.object(forInfoDictionaryKey: "CFBundleShortVersionString") as! String
        let config: String = "DEBUG"

        return "\(appVersion) - \(config)"
    }

    public var userAuthContext: UserAuthContext? = nil
    public var autoLoginEnabled: Bool = false
    public var rememberMe: Bool = false
    public var syncConfig: SynchronizationConfig

    public required init() {
        syncConfig = defaults.syncConfig
    }
}
