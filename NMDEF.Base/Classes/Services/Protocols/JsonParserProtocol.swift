//
// Created by Róbert PAPP on 2019-02-28.
//

protocol JsonParserProtocol {
    associatedtype ResponseType

    func parseResponseByResponseType(response: Data) -> ResponseType
}
