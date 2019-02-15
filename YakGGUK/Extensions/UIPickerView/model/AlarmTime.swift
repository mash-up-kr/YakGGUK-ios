//
//  AlarmTime.swift
//  YakGGUK
//
//  Created by 김선재 on 14/02/2019.
//  Copyright © 2019 team1. All rights reserved.
//

import Foundation

enum EnumAMPM: String {
    case eAM = "오전"
    case ePM = "오후"
}

class AlarmTime: NSObject, NSCoding {
    var mHour: Int
    var mMinute: Int
    var mAmpm: EnumAMPM
    
    override init() {
        mHour = 1
        mMinute = 0
        mAmpm = .eAM
    }
    
    init(hour: Int, minute: Int, ampm: EnumAMPM) {
        mHour = hour
        mMinute = minute
        mAmpm = ampm
    }
    
    required convenience init?(coder aDecoder: NSCoder) {
        let hour = aDecoder.decodeInteger(forKey: "hour")
        let minute = aDecoder.decodeInteger(forKey: "minute")
        let ampm = aDecoder.decodeObject(forKey: "ampm") as? String
        let eAmpm = EnumAMPM(rawValue: ampm!)
        
        self.init(hour: hour, minute: minute, ampm: eAmpm!)
    }
    
    func encode(with aCoder: NSCoder) {
        aCoder.encode(mHour, forKey: "hour")
        aCoder.encode(mMinute, forKey: "minute")
        aCoder.encode(mAmpm.rawValue, forKey: "ampm")
    }
}
