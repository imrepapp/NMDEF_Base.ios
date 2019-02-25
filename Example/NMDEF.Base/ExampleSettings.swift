//
// Created by Papp Imre on 2019-02-20.
// Copyright (c) 2019 CocoaPods. All rights reserved.
//

import NMDEF_Base

class ExampleSettings: BaseSettings {
    override var apiUrl: String { return "overriden variable" }
    override var appName: String { return "Example application" }
    var exampleVar: String { return  "EXAMPLE VAR" }
}
