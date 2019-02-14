//
//  TimeView.swift
//  YakGGUK
//
//  Created by 김선재 on 14/02/2019.
//  Copyright © 2019 team1. All rights reserved.
//

import UIKit

class TimeView: UIView {

    let nibName = "TimeView"
    var contentView: UIView?
    
    @IBOutlet weak var mSelectedView: UIView!
    
    @IBOutlet weak var mHourPickerView: HourPickerView!
    
    @IBOutlet weak var mMinutePickerView: MinutePickerView!
    
    @IBOutlet weak var mAmPmPickerView: AmPmPickerView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        xibSetup()
    }
    
    func xibSetup() {
        guard let view = loadViewFromNib() else { return }
        view.frame = bounds
        view.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        addSubview(view)
        contentView = view
    }

    func loadViewFromNib() -> UIView? {
        let bundle = Bundle(for: type(of: self))
        let nib = UINib(nibName: nibName, bundle: bundle)
        return nib.instantiate(withOwner: self, options: nil).first as? UIView
    }
    
    func getTime() -> AlarmTime {
        let hour = mHourPickerView.getHour()
        let minute = mMinutePickerView.getMinute()
        let ampm = mAmPmPickerView.getAmPm()
        
        return AlarmTime(hour: hour, minute: minute, ampm: ampm)
    }
    
    override func prepareForInterfaceBuilder() {
        super.prepareForInterfaceBuilder()
        xibSetup()
        contentView?.prepareForInterfaceBuilder()
    }
}
