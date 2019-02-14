//
//  AlarmTime.swift
//  YakGGUK
//
//  Created by 김선재 on 14/02/2019.
//  Copyright © 2019 team1. All rights reserved.
//

import Foundation

enum EnumAMPM {
    case eAM
    case ePM
    
    func description() -> String {
        switch self {
        case .eAM:
            return "오전"
        case .ePM:
            return "오후"
        }
    }
}

class AlarmTime {
    var mHour: Int
    var mMinute: Int
    var mAmpm: EnumAMPM
    
    init() {
        mHour = 1
        mMinute = 0
        mAmpm = .eAM
    }
    
    init(hour: Int, minute: Int, ampm: EnumAMPM) {
        mHour = hour
        mMinute = minute
        mAmpm = ampm
    }
}
