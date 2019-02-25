//
// Created by Róbert PAPP on 2019-02-15.
//

import Foundation

public class UserAuthContext {
    var hcmWorker: CLong?

    var password: String

    var selectedConfig: Configuration?

    var userIdentifier: String

    var dataAreaId: String?

    var currentUserId: String?

    init(userIdentifier: String, password: String) {
        self.userIdentifier = userIdentifier
        self.password = password
    }
}
