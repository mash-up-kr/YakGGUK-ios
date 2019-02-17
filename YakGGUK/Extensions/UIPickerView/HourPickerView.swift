//
//  HourPickerView.swift
//  YakGGUK
//
//  Created by 김선재 on 14/02/2019.
//  Copyright © 2019 team1. All rights reserved.
//

import UIKit

class HourPickerView: UIPickerView {
    var mHourData: [String] = []
    
    let pickerDataSize = 100_000

    override func awakeFromNib() {
        for hour in 1...12 {
            mHourData.append("\(String(format: "%02d", hour))")
        }
        
        delegate = self
        dataSource = self
        
        let pickerViewMiddle = ((pickerDataSize / mHourData.count) / 2) * mHourData.count
        selectRow(pickerViewMiddle, inComponent: 0, animated: false)
        
        self.subviews.forEach {
            $0.layer.borderWidth = 0
            $0.isHidden = $0.frame.height <= 1.0
        }
    }
    
    func getHour() -> Int {
        let selectedIndex = selectedRow(inComponent: 0)
        if let hour = Int(mHourData[selectedIndex % mHourData.count]) {
            return hour
        }
        
        return 1
    }
    
}

extension HourPickerView: UIPickerViewDataSource {
    public func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    public func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return pickerDataSize
    }
}

extension HourPickerView: UIPickerViewDelegate {
    func pickerView(_ pickerView: UIPickerView, rowHeightForComponent component: Int) -> CGFloat {
        return 47.0
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return mHourData[row % mHourData.count]
    }
    
    func pickerView(_ pickerView: UIPickerView, viewForRow row: Int, forComponent component: Int, reusing view: UIView?) -> UIView {
        var pickerLabel: UILabel? = (view as? UILabel)
        
        if pickerLabel == nil {
            pickerLabel = UILabel()
            
            pickerLabel?.font = UIFont(name: "SFProDisplay-Medium", size: 32.0)
            pickerLabel?.textAlignment = .center
        }
        
        pickerLabel?.text = mHourData[row % mHourData.count]
        pickerLabel?.textColor = UIColor(named: "warmBlue")
        
        return pickerLabel!
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        let pickerViewMiddle = ((pickerDataSize / mHourData.count) / 2) * mHourData.count
        let position = pickerViewMiddle + (row % mHourData.count)
        pickerView.selectRow(position, inComponent: 0, animated: false)
    }
}
