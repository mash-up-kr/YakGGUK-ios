//
//  NetworkProvider.swift
//  YakGGUK
//
//  Created by juhee on 15/02/2019.
//  Copyright © 2019 team1. All rights reserved.
//

import Foundation
import Moya
import Alamofire

struct NetworkProvider {
    static let provider = MoyaProvider<Api>(plugins: [NetworkLoggerPlugin(verbose: true)])
    static func request<DecodeType: Decodable>(
        _ dump: DecodeType.Type,
        target: Api,
        success successCallback: @escaping (DecodeType) -> Void,
        error errorCallback: @escaping (Error) -> Void = { error in
        print("error : \(error)")
        },
        failure failureCallback: @escaping (MoyaError) -> Void  = { failure in
        print("failure : \(failure)")
        }) {
        provider.request(target) { (result) in
            switch result {
            case .success(let response):
                do {
                    let filterResponse = try response.filterSuccessfulStatusCodes()
                    let data = try filterResponse.map(DecodeType.self)
                    successCallback(data)
                } catch let error {
                    errorCallback(error)
                }
            case .failure(let error):
                failureCallback(error)
            }
        }
    }
}
