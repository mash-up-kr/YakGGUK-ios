//
//  AmPmPickerView.swift
//  YakGGUK
//
//  Created by 김선재 on 14/02/2019.
//  Copyright © 2019 team1. All rights reserved.
//

import UIKit

class AmPmPickerView: UIPickerView {
    var mAmPms: [String] = []

    override func awakeFromNib() {
        mAmPms.append("오전")
        mAmPms.append("오후")
        
        delegate = self
        dataSource = self
        
        selectRow(0, inComponent: 0, animated: false)
        
        self.subviews.forEach {
            $0.layer.borderWidth = 0
            $0.isHidden = $0.frame.height <= 1.0
        }
    }
    
    func getAmPm() -> EnumAMPM {
        let selectedIndex = selectedRow(inComponent: 0)
        
        if selectedIndex == 0 {
            return .eAM
        } else {
            return .ePM
        }
    }
}

extension AmPmPickerView: UIPickerViewDataSource {
    public func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    public func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return mAmPms.count
    }
}

extension AmPmPickerView: UIPickerViewDelegate {
    func pickerView(_ pickerView: UIPickerView, rowHeightForComponent component: Int) -> CGFloat {
        return 47.0
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return mAmPms[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, viewForRow row: Int, forComponent component: Int, reusing view: UIView?) -> UIView {
        var pickerLabel: UILabel? = (view as? UILabel)
        
        if pickerLabel == nil {
            pickerLabel = UILabel()
            
            pickerLabel?.font = UIFont(name: "AppleSDGothicNeo-Regular", size: 20.0)
            pickerLabel?.textAlignment = .center
        }
        
        pickerLabel?.text = mAmPms[row]
        pickerLabel?.textColor = UIColor(named: "warmBlue")
        
        return pickerLabel!
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        pickerView.selectRow(row, inComponent: 0, animated: false)
    }
}
