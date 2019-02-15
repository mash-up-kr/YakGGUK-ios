//
//  PillDetailCellType.swift
//  YakGGUK
//
//  Created by juhee on 15/02/2019.
//  Copyright © 2019 team1. All rights reserved.
//

import Foundation

enum PillDetailCellType: Int {
    
    case name = 0
    case companyName = 1
    case apperance = 2
    case content = 3
    case intake = 4
    case precautions = 5
    case expirationDate = 6
    
    var title: String {
        switch self {
        case .name:
            return "제품명"
        case .companyName:
            return "업체명"
        case .apperance:
            return "약 형태(성상)"
        case .content:
            return "기능"
        case .intake:
            return "섭취량"
        case .precautions:
            return "주의사항"
        case .expirationDate:
            return "유통기한"
        }
    }
}
