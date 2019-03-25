//
// Created by Papp Imre on 2019-02-21.
// Copyright (c) 2019 CocoaPods. All rights reserved.
//

public struct SynchronizationConfig: Codable {
    public var automatic: Bool
    public var lastTime: Date
    public var lastDuration: Int
    public var intervalFullSec: Int
    public var intervalPartSec: Int
    public var reconnectMethod: ReconnectMethod

    public init(automatic: Bool, lastTime: Date, lastDuration: Int, intervalFullSec: Int, intervalPartSec: Int, reconnectMethod: ReconnectMethod) {
        self.automatic = automatic
        self.lastTime = lastTime
        self.lastDuration = lastDuration
        self.intervalFullSec = intervalFullSec
        self.intervalPartSec = intervalPartSec
        self.reconnectMethod = reconnectMethod
    }
}
