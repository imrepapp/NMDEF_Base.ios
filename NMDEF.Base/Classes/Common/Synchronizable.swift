//
// Created by Papp Imre on 2019-01-22.
// Copyright (c) 2019 XAPT Kft. All rights reserved.
//

//https://github.com/RxSwiftCommunity/RxFlow/blob/develop/RxFlow/Synchronizable.swift
import RxFlow

public extension Synchronizable {
    func synchronized<T>( _ action: () -> T) -> T {
        objc_sync_enter(self)
        let result = action()
        objc_sync_exit(self)
        return result
    }
}
