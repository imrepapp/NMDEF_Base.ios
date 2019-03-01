//
// Created by Róbert PAPP on 2019-02-18.
//

import Moya

extension AuthServices: TargetType {
    public var baseURL: URL {
        //TODO: Get the baseUrl from settings
        return URL(string: "https://mobile-demo.xapt.com/env/dev/0338/nmdef/rental")!
    }

    public var path: String {
        switch self {
        case .login:
            return "/api/users"

        case .selectConfig:
            return "/api/users/"

        case .getWorkerData:
            return "/api/workerdata"
        }
    }

    public var method: Moya.Method {
        switch self {
        case .login:
            return .post

        case .selectConfig:
            return .put

        case .getWorkerData:
            return .get

        }
    }

    public var task: Task {
        switch self {
        case .login(let email, let password):
            return .requestParameters(parameters: ["email": email, "password": password], encoding: URLEncoding.httpBody)

        case .selectConfig(let id, let sessionId):
            return .requestParameters(parameters: ["id": id, "sessionId": sessionId], encoding: URLEncoding.queryString)

        case .getWorkerData:
            return .requestPlain
        }
    }

    public var sampleData: Data {
        switch self {
        case .login, .selectConfig, .getWorkerData:
            return "data".utf8Encoded
        }
    }

    public var headers: [String: String]? {
        switch self {
        //TODO: Get device id and put inside the dictionary
        case .login, .selectConfig:
            return ["Content-type": "application/x-www-form-urlencoded", "DeviceId": "1234test123"]
        case .getWorkerData(let token):
            return ["Content-type": "application/x-www-form-urlencoded", "DeviceId": "1234test123", "X-ZUMO-AUTH": token, "ZUMO-API-VERSION": "2.0.0"]
        }
    }
}

private extension String {
    var utf8Encoded: Data {
        return data(using: .utf8)!
    }
}

