//
//  AlarmClockView.swift
//  YakGGUK
//
//  Created by Lee Junho on 10/02/2019.
//  Copyright © 2019 team1. All rights reserved.
//

import UIKit

class AlarmClockView: UIView {
    @IBOutlet private weak var contentView: UIView!
    @IBOutlet private weak var topView: UIView!
    @IBOutlet private weak var titleLabel: UILabel!
    @IBOutlet private weak var hourLabel: UILabel!
    @IBOutlet private weak var minuteLabel: UILabel!
    @IBOutlet private weak var meridiemLabel: UILabel!
    
    private var calendar: Calendar {
        var temp = Calendar.current
        temp.locale = Locale.current
        
        return temp
    }
    private var timeFormatter: DateFormatter {
        let temp = DateFormatter()
        temp.dateFormat = "HH:mm"
        return temp
    }
    var intakeTime: IntakeTime? {
        didSet {
            titleLabel.text = "\(intakeTime?.title ?? "") 알람"
            
            if let time = intakeTime {
                switch time {
                case .morning:
                    date = timeFormatter.date(from: "09:00")
                case .noon:
                    date = timeFormatter.date(from: "12:00")
                case .evening:
                    date = timeFormatter.date(from: "18:00")
                case .night:
                    date = timeFormatter.date(from: "21:00")
                }
            }
        }
    }
    var clockAction: ((Date) -> Void)?
    var date: Date? {
        didSet {
            if let date = date {
                var meridiem = "오전"
                var hour = calendar.component(.hour, from: date)
                
                if hour > 12 {
                    hour = hour % 12
                    meridiem = "오후"
                } else if hour == 12 {
                    meridiem = "오후"
                }
                
                hourLabel.text = "\(hour)"
                minuteLabel.text = String(format: "%02d", calendar.component(.minute, from: date))
                meridiemLabel.text = meridiem
            }
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        loadNib()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        loadNib()
    }
    
    private func loadNib() {
        Bundle.main.loadNibNamed("AlarmClockView", owner: self, options: nil)
        addSubview(contentView)
        
        contentView.frame = self.bounds
        contentView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        
        topView.backgroundColor = horizontalGradientColor(frame: topView.frame)
    }
}

extension AlarmClockView {
    @IBAction func tapClockButton(_ sender: UIButton) {
        if let date = date {
            clockAction?(date)
        }
    }
}
