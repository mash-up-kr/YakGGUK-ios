//
//  MedicineModel.swift
//  YakGGUK
//
//  Created by 김선재 on 24/11/2018.
//  Copyright © 2018 team1. All rights reserved.
//

import Foundation

class MedicineModel {
    var medicineId: Int = 0
    var name: String
    var campanyName: String = "제약회사"
    var pilType: String = "약 형태"
    var description: String = "섭취량"
    var dosage: String = "섭취량"
    var cautionInfo: String = "주의사항"
    var expirationDate: String = "2018/12/31"
    var imageSource: String = ""
    
    var alarmDays: [Int] = [0, 0, 0, 0, 0, 0, 0]
    
    init(name: String, description: String) {
        self.name = name
        self.description = description
    }
    
    init(imageSource: String, medicineId: Int, name: String, description: String) {
        self.imageSource = imageSource
        self.medicineId = medicineId
        self.name = name
        self.description = description
    }
}
