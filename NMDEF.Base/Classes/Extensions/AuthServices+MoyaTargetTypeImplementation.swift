//
// Created by Róbert PAPP on 2019-02-18.
//

import Moya

extension AuthServices: TargetType {
    public var baseURL: URL {
        //TODO: Get the baseUrl from settings
        return URL(string: "https://mobile-demo.xapt.com/reverse170/mobapi/sales")!
    }

    public var path: String {
        switch self {
        case .login(_, _):
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
        case .login(let email, let password):
            return .requestParameters(parameters: ["email": "\(email)", "password": password], encoding: URLEncoding.queryString)
        }
    }

    public var sampleData: Data {
        switch self {
        case .login:
            return "data".utf8Encoded
        }
    }

    public var headers: [String: String]? {
        return ["Content-type": "application/x-www-form-urlencoded"]
    }
}

private extension String {
    var utf8Encoded: Data {
        return data(using: .utf8)!
    }
}

