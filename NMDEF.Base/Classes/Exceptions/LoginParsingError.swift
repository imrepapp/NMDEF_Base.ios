//
// Created by Róbert PAPP on 2019-03-05.
//

public enum LoginParsingError: Error {

    case jsonParsingError(String)
    case loginError(String)
}
