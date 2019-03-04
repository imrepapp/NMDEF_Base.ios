//
// Created by Róbert PAPP on 2019-03-04.
//

public class WorkerData:Decodable,CustomStringConvertible{

    public var hcmWorkerId : CLong

    public var dataAreaId: String

    init(hcmWorkerId: CLong, dataAreaId: String) {
        self.hcmWorkerId = hcmWorkerId
        self.dataAreaId = dataAreaId
    }

    enum CodingKeys: String, CodingKey {
        case hcmWorkerId = "HcmWorkerId"
        case dataAreaId = "DataAreaId"
    }

    public var description: String {
        return "HcmWorkerId: \(hcmWorkerId) data area id: \(dataAreaId)"
    }
}
