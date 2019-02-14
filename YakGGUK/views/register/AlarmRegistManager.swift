//
//  AlarmRegistManager.swift
//  YakGGUK
//
//  Created by Lee Junho on 10/02/2019.
//  Copyright © 2019 team1. All rights reserved.
//

import Foundation

struct Alarmmmmmmm {
    var date: Date
    var repeatingDay: [Weekend]
    var medicine: MedicineModel
    var sound: AlarmSound
}

class AlarmRegistManager {
    static let shared = AlarmRegistManager()
}

extension AlarmRegistManager {
    func save(_ alarms: [Alarmmmmmmm]) {
        print(alarms)
    }
}
