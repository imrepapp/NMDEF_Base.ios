//
//  AuthServices.swift
//  Alamofire
//
//  Created by Róbert PAPP on 2019. 02. 18..
//

public enum AuthServices {

    case login(emailAddress: String, password: String)

    case selectConfig(id: Int, sessionId: String)

    case getWorkerData(token: String)
}
