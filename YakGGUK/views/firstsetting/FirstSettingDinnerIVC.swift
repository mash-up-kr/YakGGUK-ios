//
//  FirstSettingDinnerIVC.swift
//  YakGGUK
//
//  Created by 김선재 on 09/02/2019.
//  Copyright © 2019 team1. All rights reserved.
//

import UIKit

class FirstSettingDinnerIVC: UIViewController {
    
    @IBOutlet weak var mTimeView: TimeView!
    var mAlarmTime: AlarmTime?
    
}

extension FirstSettingDinnerIVC: INextable {
    
    func nextable() {
        mAlarmTime = mTimeView.getTime()
    }
    
}
