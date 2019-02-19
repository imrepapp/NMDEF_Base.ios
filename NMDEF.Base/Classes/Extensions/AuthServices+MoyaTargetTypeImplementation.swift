//
// Created by Róbert PAPP on 2019-02-18.
//

import Moya

extension AuthServices: TargetType {
    public var baseURL: URL {
        //TODO: Get the baseUrl from settings
        return URL(string: "https://api.com")!
    }

    public var path: String {
        switch self {
        case .login:
            return "/api/users"
        }
    }

    public var method: Moya.Method {
        switch self {
        case .login:
            return .post
        }
    }

    public var task: Task {
        switch self {
        case .login:
            return .requestPlain
        }

    }

    public var sampleData: Data {
        switch self {
        case .login:
            return "data".utf8Encoded
        }
    }

    public var headers: [String: String]? {
        return ["Content-type": "application/json"]
    }
}

private extension String{
    var utf8Encoded: Data{
        return data(using: .utf8)!
    }
}

