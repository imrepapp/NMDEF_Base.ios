//
// Created by Róbert PAPP on 2019-02-15.
//

public class UserAuthContext: Codable {
    var hcmWorker: CLong?

    var password: String

    public var selectedConfig: Configuration?

    var userIdentifier: String

    var dataAreaId: String?

    var currentUserId: String?

    init(userIdentifier: String, password: String) {
        self.userIdentifier = userIdentifier
        self.password = password
    }
}
