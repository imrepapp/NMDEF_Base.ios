//
// Created by Attila AMBRUS on 2019-03-21.
//

import Moya
import RxSwift

public extension Reactive where Base: MoyaProviderType {
    func send<T: Decodable>(_ target: Base.Target, callbackQueue: DispatchQueue? = nil) -> Single<T> {
        return Single<T>.create { [weak base] single in
            let cancellableToken = base?.request(target, callbackQueue: callbackQueue, progress: nil) { result in
                switch result {
                case let .success(response):
                    do {
                        single(.success(try (response as Moya.Response).data.parse(T.self)))
                    } catch {
                        single(.error(error))
                    }
                case let .failure(error):
                    single(.error(error))
                }
            }

            return Disposables.create {
                cancellableToken?.cancel()
            }
        }
    }
}

public enum Parsing: Error {
    case error(msg: String)
}

public extension Data {
    func parse<T: Decodable>(_ type: T.Type) throws -> T {
        do {
            guard let response = try? JSONDecoder().decode(T.self, from: self) else {
                let json = try JSONSerialization.jsonObject(with: self, options: []) as! [String: AnyObject]
                if let msg = json["Message"] as? String {
                    throw Parsing.error(msg: msg)
                }
                throw Parsing.error(msg: "Error while parsing JSON: \(String(data: self, encoding: .utf8))")
            }

            return response as T
        } catch {
            throw Parsing.error(msg: error.localizedDescription)
        }
    }
}

