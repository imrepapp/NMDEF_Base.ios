//
// Created by Róbert PAPP on 2019-02-18.
//

import Moya

extension AuthServices: TargetType {
    public var baseURL: URL {
        //TODO: Get the baseUrl from settings
        return URL(string: "https://mobile-demo.xapt.com/test/sales")!
    }

    public var path: String {
        switch self {
        case .login(_, _):
            return "/api/users"

        case .selectConfig(let id, _):
            return "/api/users/\(id)"

        case .getDataAreaId(_):
            return "/api/DataAreaId"

        case .getCurrentUserId(_):
            return "/api/CurUserId"
        }
    }

    public var method: Moya.Method {
        switch self {
        case .login:
            return .post

        case .selectConfig:
            return .put

        case .getDataAreaId, .getCurrentUserId:
            return .get

        }
    }

    public var task: Task {
        switch self {
        case .login(let email, let password):
            return .requestParameters(parameters: ["email": email, "password": password], encoding: URLEncoding.httpBody)

        case .selectConfig(_, _):
            return .requestParameters(parameters: ["": ""], encoding: URLEncoding.httpBody)

        case .getDataAreaId(_):
            return .requestParameters(parameters: ["": ""], encoding: URLEncoding.httpBody)

        case .getCurrentUserId(_):
            return .requestParameters(parameters: ["": ""], encoding: URLEncoding.httpBody)
        }
    }

    public var sampleData: Data {
        switch self {
        case .login, .selectConfig, .getDataAreaId, .getCurrentUserId:
            return "data".utf8Encoded
        }
    }

    public var headers: [String: String]? {
        switch self {
        case .login, .selectConfig:
            return ["Content-type": "application/x-www-form-urlencoded", "DeviceId": "1234test123"]
        case .getCurrentUserId(let token):
            return ["Content-type": "application/x-www-form-urlencoded", "DeviceId": "1234test123", "X-ZUMO-AUTH": token]

        case .getDataAreaId(let token):
            return ["Content-type": "application/x-www-form-urlencoded", "DeviceId": "1234test123", "X-ZUMO-AUTH": token]
        }
    }
}

private extension String {
    var utf8Encoded: Data {
        return data(using: .utf8)!
    }
}

