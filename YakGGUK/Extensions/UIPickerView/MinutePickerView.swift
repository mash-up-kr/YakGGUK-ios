//
//  MinutePickerView.swift
//  YakGGUK
//
//  Created by 김선재 on 14/02/2019.
//  Copyright © 2019 team1. All rights reserved.
//

import UIKit

class MinutePickerView: UIPickerView {
    var mMinuteData: [String] = []
    
    let pickerDataSize = 100_000
    
    override func awakeFromNib() {
        for minute in stride(from: 0, to: 60, by: 5) {
            mMinuteData.append(String(format: "%02d", minute))
        }
        
        delegate = self
        dataSource = self
        
        let pickerViewMiddle = ((pickerDataSize / mMinuteData.count) / 2) * mMinuteData.count
        selectRow(pickerViewMiddle, inComponent: 0, animated: false)
        
        self.subviews.forEach {
            $0.layer.borderWidth = 0
            $0.isHidden = $0.frame.height <= 1.0
        }
    }
    
    func getMinute() -> Int {
        let selectedIndex = selectedRow(inComponent: 0)
        if let minute = Int(mMinuteData[selectedIndex % mMinuteData.count]) {
            return minute
        }
        
        return 0
    }
}

extension MinutePickerView: UIPickerViewDataSource {
    public func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    public func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return pickerDataSize
    }
}

extension MinutePickerView: UIPickerViewDelegate {
    func pickerView(_ pickerView: UIPickerView, rowHeightForComponent component: Int) -> CGFloat {
        return 47.0
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return mMinuteData[row % mMinuteData.count]
    }
    
    func pickerView(_ pickerView: UIPickerView, viewForRow row: Int, forComponent component: Int, reusing view: UIView?) -> UIView {
        var pickerLabel: UILabel? = (view as? UILabel)
        
        if pickerLabel == nil {
            pickerLabel = UILabel()
            
            pickerLabel?.font = UIFont(name: "SFProDisplay-Medium", size: 32.0)
            pickerLabel?.textAlignment = .center
        }
        
        pickerLabel?.text = mMinuteData[row % mMinuteData.count]
        pickerLabel?.textColor = UIColor(named: "warmBlue")
        
        return pickerLabel!
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        let pickerViewMiddle = ((pickerDataSize / mMinuteData.count) / 2) * mMinuteData.count
        let position = pickerViewMiddle + (row % mMinuteData.count)
        pickerView.selectRow(position, inComponent: 0, animated: false)
    }
}
