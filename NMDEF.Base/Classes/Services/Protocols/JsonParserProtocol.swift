//
// Created by Róbert PAPP on 2019-02-28.
//

protocol JsonParserProtocol {
    associatedtype LoginResponseType
    associatedtype HcmWorkerType

    func parseResponseByResponseType(response: Data) -> LoginResponseType

    func parseResponseByHcmWorkerType(response: Data) -> HcmWorkerType
}
