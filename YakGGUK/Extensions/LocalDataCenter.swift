//
//  LocalDataCenter.swift
//  YakGGUK
//
//  Created by 김선재 on 15/02/2019.
//  Copyright © 2019 team1. All rights reserved.
//

import Foundation

class LocalDataCenter {
    
    static func loadAlarmTimes() -> [AlarmTime] {
        guard let unarchivedData: Data = UserDefaults.standard.value(forKey: "AlarmTimes") as? Data else {
            return []
        }
        
        do {
            guard let alarmTimes: [AlarmTime] = try NSKeyedUnarchiver.unarchiveTopLevelObjectWithData(unarchivedData) as? [AlarmTime] else {
                fatalError("b")
                return []
            }
            
            return alarmTimes
        } catch {
            fatalError("c")
            return []
        }
    }
    
    static func saveAlarmTimes(alarmTimes: [AlarmTime]) -> Bool {
        if (alarmTimes.count != 4) {
            return false
        }
        
        do {
            let userDefaults = UserDefaults.standard
            let encodedData: Data = try NSKeyedArchiver.archivedData(withRootObject: alarmTimes as Array, requiringSecureCoding: false)
            userDefaults.setValue(encodedData, forKey: "AlarmTimes")
            userDefaults.synchronize()
            
            return true
        } catch {
            return false
        }
    }
    
    static func clearAlarmTimes() {
        UserDefaults.standard.removeObject(forKey: "AlarmTimes")
        UserDefaults.standard.synchronize()
    }
    
}
