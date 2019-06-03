//
// Created by Papp Imre on 2019-02-19.
//

open class BaseSettings: BaseSettingsProtocol {
    private let defaults = BaseSettingsDefaults()
    private var cache: [String: Any] = [:]

    private enum Keys: String, SettingKeys {
        case USER_AUTH_CONTEXT
        case AUTO_LOGIN_ENABLED
        case REMEMBER_ME
        case SYNC_CONFIG
        case API_URL
    }

    public var apiUrl: String {
        get {
            return loadPrimitive(Keys.API_URL, default: defaults.apiUrl)
        }
        set {
            storePrimitive(Keys.API_URL, value: newValue)
        }
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
        if let context = self.userAuthContext, context.selectedConfig != nil, context.hcmWorkerId > 0 {
            return "NS\(context.selectedConfig?.id ?? 0)-\(context.hcmWorkerId).react"
        }
        return nil
    }

    public var appVersion: String {
        let appVersion: String = Bundle.main.object(forInfoDictionaryKey: "CFBundleShortVersionString") as! String
        let config: String = "DEBUG"

        return "\(appVersion) - \(config)"
    }

    public var userAuthContext: UserAuthContext? {
        get {
            return loadObject(Keys.USER_AUTH_CONTEXT, default: defaults.userAuthContext)
        }
        set {
            storeObject(Keys.USER_AUTH_CONTEXT, value: newValue)
        }
    }

    public var autoLoginEnabled: Bool {
        get {
            return loadPrimitive(Keys.AUTO_LOGIN_ENABLED, default: defaults.autoLoginEnabled)
        }
        set {
            storePrimitive(Keys.AUTO_LOGIN_ENABLED, value: newValue)
        }
    }

    public var rememberMe: Bool {
        get {
            return loadPrimitive(Keys.REMEMBER_ME, default: defaults.rememberMe)
        }
        set {
            storePrimitive(Keys.REMEMBER_ME, value: newValue)
        }
    }

    public var syncConfig: SynchronizationConfig {
        get {
            return loadObject(Keys.SYNC_CONFIG, default: defaults.syncConfig)
        }
        set {
            storeObject(Keys.SYNC_CONFIG, value: newValue)
        }
    }

    public required init() {
    }

    public func storePrimitive<K, T>(_ key: K, value: T) where K: SettingKeys, K.RawValue == String {
        UserDefaults.standard.set(value, forKey: key.rawValue)
    }

    public func loadPrimitive<K, T>(_ key: K, default defaultValue: T) -> T where K: SettingKeys, K.RawValue == String {
        return UserDefaults.standard.object(forKey: key.rawValue) as? T ?? defaultValue
    }

    public func storeObject<K, T>(_ key: K, value: T) where T: Codable, K: SettingKeys, K.RawValue == String {
        let jsonEncoder = JSONEncoder()
        do {
            UserDefaults.standard.set(try jsonEncoder.encode(value), forKey: key.rawValue)
            //clear from cache
            self.cache.removeValue(forKey: key.rawValue);
        } catch {
            print("can't store the object with key: \(key.rawValue)")
        }
    }

    public func loadObject<K, T>(_ key: K, default defaultValue: T) -> T where T: Codable, K: SettingKeys, K.RawValue == String {
        guard let cached = cache[key.rawValue] else {
            guard let data = UserDefaults.standard.object(forKey: key.rawValue) as? Data else {
                print("object with key: \(key.rawValue) can't cast to Data type")
                return defaultValue
            }
            let jsonDecoder = JSONDecoder()
            do {
                return try jsonDecoder.decode(T.self, from: data)
            } catch {
                print("can't load the object with key: \(key.rawValue)")
                return defaultValue
            }
        }
        return cached as! T
    }
}
