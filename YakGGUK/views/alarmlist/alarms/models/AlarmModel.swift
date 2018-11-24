//
//  AlarmModel.swift
//  YakGGUK
//
//  Created by 김선재 on 24/11/2018.
//  Copyright © 2018 team1. All rights reserved.
//

import Foundation

enum enumWhen: Int {
    case WAKEUP         = 0
    case MORNING        = 1
    case LUNCH          = 2
    case DINNER         = 3
    case NIGHT          = 4
    
    func description() -> String {
        switch self {
        case .WAKEUP:
            return "기상"
        case .MORNING:
            return "아침"
        case .LUNCH:
            return "점심"
        case .DINNER:
            return "저녁"
        case .NIGHT:
            return "취침"
        }
    }
}

enum enumWhenType: Int {
    case BEFORE         = 0
    case AFTER          = 1
    
    func description() -> String {
        switch self {
        case .BEFORE:
            return "식전"
        case .AFTER:
            return "식후"
        }
    }
}

class AlarmModel {
    var eWhen: enumWhen
    var eWhenType: enumWhenType
    
    var time: String
    var medicines: [MedicineModel]
    
    init(eWhen: enumWhen, eWhenType: enumWhenType, time: String, medicines: [MedicineModel]) {
        self.eWhen = eWhen
        self.eWhenType = eWhenType
        self.time = time
        self.medicines = medicines
    }
}
