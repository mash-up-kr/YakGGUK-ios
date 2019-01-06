//
//  AlarmModel.swift
//  YakGGUK
//
//  Created by 김선재 on 24/11/2018.
//  Copyright © 2018 team1. All rights reserved.
//

import Foundation

enum EnumWhen: Int {
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

class AlarmModel {
    var eWhen: EnumWhen
    
    var time: String
    var medicines: [MedicineModel]
    var isExpand: Bool = false
    
    init(eWhen: EnumWhen, time: String, medicines: [MedicineModel]) {
        self.eWhen = eWhen
        self.time = time
        self.medicines = medicines
    }
}
