//
// Created by Róbert PAPP on 2019-02-15.
//

public class UserAuthContext: Codable {
    private var _hcmWorker: CLong?
    private var _dataAreaId: String?

    public var selectedConfig: Configuration?
    public var userIdentifier: String
    public var password: String

    public var hcmWorkerId: CLong {
        get {
            return _hcmWorker ?? 0
        }
        set {
            _hcmWorker = newValue
        }
    }

    public var dataAreaId: String {
        get {
            return _dataAreaId ?? ""
        }
        set {
            _dataAreaId = newValue
        }
    }

    public init(userIdentifier: String, password: String) {
        self.userIdentifier = userIdentifier
        self.password = password
    }

    public init(userIdentifier: String, password: String, config: Configuration) {
        self.userIdentifier = userIdentifier
        self.password = password
        self.selectedConfig = config
    }
}
