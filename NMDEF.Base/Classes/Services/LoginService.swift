//
// Created by Róbert PAPP on 2019-02-18.
//

import Foundation

class LoginService : TargetType {
    var baseUrl: URL {
        //TODO: Get the baseUrl from settings
        return URL(string: "https://api.com")
    }

    var path: String {
        switch self {
        case .login:
            return "/api/users"
        }
    }

    var method: Moya.Method {
        switch self {
        case .login:
            return .post
        }
    }

    var task: Task {
        switch self {
        case .login:
            return .requestPlain
        }
    }

    var sampleData: Data {
        switch self {
        case .login{
            return "data".utf8
        }
        }
    }

    var headers: [String: String]? {
        return ["Content-type": "application/json"]
    }
}
