//
// Created by Papp Imre on 2019-02-21.
// Copyright (c) 2019 CocoaPods. All rights reserved.
//

import Foundation

public struct SynchronizationConfig {
    var automatic: Bool
    var lastTime: Date
    var lastDuration: Int
    var intervalFullSec: Int
    var intervalPartSec: Int
    var reconnectMethod: ReconnectMethod
}
