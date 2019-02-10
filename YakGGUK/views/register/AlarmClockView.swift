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
    
    var intakeTime: IntakeTime? {
        didSet {
            titleLabel.text = "\(intakeTime?.title ?? "") 알람"
        }
    }
    var clockAction: (() -> Void)?
    
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
        clockAction?()
    }
}
