//
//  AuthServices.swift
//  Alamofire
//
//  Created by Róbert PAPP on 2019. 02. 18..
//

import Moya

enum AuthServices {
    case login
}

extension AuthServices: TargetType {
    public var baseURL: URL {
        //TODO: Get the baseUrl from settings
        return URL(string: "https://api.com")!
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
        case .login:
            return "data".utf8Encoded
        }
    }

    var headers: [String: String]? {
        return ["Content-type": "application/json"]
    }

}

private extension String {
    var utf8Encoded : Data{
        return data(using: .utf8)!
    }
}

