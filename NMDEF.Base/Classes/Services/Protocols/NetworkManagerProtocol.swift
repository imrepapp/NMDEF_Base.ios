//
// Created by Róbert PAPP on 2019-04-01.
//

import Reachability

public protocol NetworkManagerProtocol {
    func getActualConnection() -> Reachability.Connection

    func getcurrentNetworkStatus() -> Bool
}
