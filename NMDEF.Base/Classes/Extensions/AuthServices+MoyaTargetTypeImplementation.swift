//
// Created by Róbert PAPP on 2019-02-18.
//

import Moya

extension AuthServices: TargetType {
    public var baseURL: URL {
        //TODO: Get the baseUrl from settings
        return URL(string: BaseAppDelegate.instance.settings.apiUrl)!
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
        let deviceId = UIDevice.current.identifierForVendor!.uuidString

        switch self {
        case .login, .selectConfig:
            return ["Content-type": "application/x-www-form-urlencoded", "DeviceId": deviceId]
        case .getWorkerData:
            return ["Content-type": "application/x-www-form-urlencoded", "DeviceId": deviceId, "X-ZUMO-AUTH": BaseAppDelegate.instance.token!, "ZUMO-API-VERSION": "2.0.0"]
        }
    }
}

private extension String {
    var utf8Encoded: Data {
        return data(using: .utf8)!
    }
}

