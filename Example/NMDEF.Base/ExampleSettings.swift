//
// Created by Papp Imre on 2019-02-20.
// Copyright (c) 2019 CocoaPods. All rights reserved.
//

import NMDEF_Base


public protocol ExampleSettingsConstants {
    var exampleConstant: String { get }
}

public protocol ExampleSettingsVariables {
    var exampleVar: String { get set }
}

class ExampleSettings: BaseSettings, ExampleSettingsConstants, ExampleSettingsVariables {
    private let defaults = ExampleSettingsDefaults()

    private enum Keys: String, SettingKeys {
        case EXAMPLE_VAR
    }

    var exampleVar: String {
        get {
            return loadPrimitive(Keys.EXAMPLE_VAR, default: defaults.exampleVar)
        }
        set {
            storePrimitive(Keys.EXAMPLE_VAR, value: newValue)
        }
    }
    private(set) var exampleConstant: String = "This is a constant."
}

struct ExampleSettingsDefaults: ExampleSettingsVariables {
    var exampleVar: String = "This is the default value of the variable"
}
