//
//  Pill.swift
//  YakGGUK
//
//  Created by juhee on 15/02/2019.
//  Copyright © 2019 team1. All rights reserved.
//

import Foundation

struct Pill: Codable {
    let apperance: String
    let company: String
    let content: String
    let crtDate: Date
    let expirationDate: String
    let intake: String
    let manageNo: String
    let name: String
    let precautions: String
    let productId: Int
    let updDate: Date
    
    init(name: String, companyName: String, apperance: String, content: String, intake: String, precautions: String, expirationDate: String) {
        self.name = name
        self.company = companyName
        self.apperance = apperance
        self.content = content
        self.intake = intake
        self.precautions = precautions
        self.expirationDate = expirationDate
        
        let today = Date()
        self.crtDate = today
        self.updDate = today
        self.manageNo = ""
        self.productId = 0
    }
    
    func info(type: PillDetailCellType) -> String {
        switch type {
        case .name:
            return name
        case .companyName:
            return company
        case .apperance:
            return apperance
        case .content:
            return content
        case .intake:
            return intake
        case .precautions:
            return precautions
        case .expirationDate:
            return expirationDate
        }
    }
}
