//
//  ViewController+Moya.swift
//  Puzzloging
//
//  Created by changgyo seo on 2023/01/15.
//

import UIKit
import Moya
import RxMoya
import RxSwift

struct Network {
    
    static let shared = Network()
    
    private let provider = MoyaProvider<TotalAPI>()
    
    func connect(type param: TotalAPI) -> Single<Codable> {
        return provider.rx
            .request(param)
            .filterSuccessfulStatusCodes()
            .map { response in
                return try! response.map(TotalAPI.returnType(of: param))
            }
    }
}
