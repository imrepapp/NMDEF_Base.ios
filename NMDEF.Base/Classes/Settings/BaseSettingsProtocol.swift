//
// Created by Papp Imre on 2019-02-20.
//

public protocol SettingKeys: RawRepresentable {
}

public protocol BaseSettingsProtocol: BaseSettingsConstants, BaseSettingsVariables {
}

public protocol BaseSettingsConstants {
    var apiUrl: String { get }
    var dataProviderUrl: String { get }
    var appName: String { get }
    var appVersion: String { get }
    var reactName: String? { get }
    var splashMaxTimoutSec: Int { get }
}

public protocol BaseSettingsVariables {
    var userAuthContext: UserAuthContext? { get set }
    var autoLoginEnabled: Bool { get set }
    var rememberMe: Bool { get set }
    var syncConfig: SynchronizationConfig { get set }
}