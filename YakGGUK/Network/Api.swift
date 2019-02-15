//
//  Api.swift
//  YakGGUK
//
//  Created by juhee on 15/02/2019.
//  Copyright © 2019 team1. All rights reserved.
//

import Moya

enum Api {
    // 바코드 검색 API
    case pillsByBarcode(_ barcode: String)
    // 바코드 정보 없을 때 상품 검색하고 사용시 바코드와 제품 데이터를 저장하는 API
    case bindBarcode(barcode: String, productId: Int)
    // 이름과 회사 이름으로 검색하는 API
    case pillsByKeyword(name: String, companyName: String?, page: Int)
    // 약 상세 정보 API
    case pill(productId: Int)
}

extension Api: TargetType {
    var baseURL: URL {
        return URL(string: "http://13.209.237.159:8080")!
    }
    var path: String {
        switch self {
        case .pillsByBarcode(let barcode):
            return "/barcodes/\(barcode)"
        case .bindBarcode:
            return "/barcodes"
        case .pillsByKeyword:
            return "/products"
        case .pill(let id):
            return "/products/\(id)"
        }
    }
    var method: Moya.Method {
        switch self {
        case .pillsByBarcode, .pillsByKeyword:
            return .get
        case .bindBarcode, .pill:
            return .post
        }
        
    }
    
    var sampleData: Data {
        // FIXME: NO Sample Data
        return stubbedResponse("sample")
    }
    
    var task: Task {
        switch self {
        case .pillsByBarcode, .pill:
            return .requestPlain
        case .pillsByKeyword(let name, let companyName, let page):
            var params: [String:Any] = ["name" : name,  "pageNo" : page]
            if let company = companyName {
                params["company"] = company
            }
            return .requestParameters(parameters: params, encoding: JSONEncoding.default)
        case .bindBarcode(let barcode, let productId):
            return .requestParameters(parameters: ["barcodeNumber" : barcode,  "productId" : productId], encoding: JSONEncoding.default)
        }
    }
    
    var headers: [String : String]? {
        switch self {
        default:
            return ["Content-type": "application/json"]
        }
    }
    
    func stubbedResponse(_ filename: String) -> Data! {
        guard let url = Bundle.main.url(forResource: filename, withExtension: "json"),
            let data = try? Data(contentsOf: url) else {
                return Data()
        }
        return data
    }
}
