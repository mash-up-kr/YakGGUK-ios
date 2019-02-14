//
//  DateModel.swift
//  YakGGUK
//
//  Created by 김선재 on 09/02/2019.
//  Copyright © 2019 team1. All rights reserved.
//

class DateModel {
    var mHour = 0
    var mMinute = 0
    var mAmpm = ""
    
    init (hour: Int, minute: Int, ampm: String) {
        mHour = hour
        mMinute = minute
        mAmpm = ampm
    }
}
