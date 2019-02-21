//
// Created by Papp Imre on 2019-02-20.
// Copyright (c) 2019 CocoaPods. All rights reserved.
//

import NMDEF_Base

protocol ExampleApiProtocol: BaseApiProtocol {

}

class ExampleApi: BaseApi, ExampleApiProtocol {
}
