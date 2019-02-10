//
//  RegisterAlarmViewController.swift
//  YakGGUK
//
//  Created by Lee Junho on 09/02/2019.
//  Copyright © 2019 team1. All rights reserved.
//

import UIKit

enum IntakeTime: Int, CaseIterable {
    case morning = 0
    case noon
    case evening
    case night
    
    var title: String {
        switch self {
        case .morning: return "기상"
        case .noon: return "점심"
        case .evening: return "저녁"
        case .night: return "취침"
        }
    }
}

class RegisterAlarmViewController: UIViewController {
    @IBOutlet private weak var sanaImageView: UIImageView!
    @IBOutlet private weak var medicineInfoView: UIView!
    @IBOutlet private weak var medicineNameLabel: UILabel!
    @IBOutlet private weak var medicineCompanyLabel: UILabel!
    @IBOutlet private weak var intakeGuideLabel: UILabel!
    @IBOutlet private weak var intakeStackView: UIStackView!
    @IBOutlet private weak var weekendLabel: UILabel!
    @IBOutlet private weak var soundLabel: UILabel!
    @IBOutlet private weak var registerButton: UIButton!
    @IBOutlet private var intakeButtons: [UIButton]!
    @IBOutlet private weak var clockPickerView: UIView!
    @IBOutlet private weak var clockPickerHeaderView: UIView!
    @IBOutlet private weak var clockPickerTitleLabel: UILabel!
    @IBOutlet private weak var clockPicker: UIDatePicker!
    
    private var intakeAlarmViews: [AlarmClockView] = []
    private var selectedAlarmView: AlarmClockView?
    
    private var selectedDay: [Weekend] = [] {
        didSet {
            if selectedDay.count == Weekend.allCases.count {
                weekendLabel.text = "매일"
            } else if selectedDay.count == 2, selectedDay.contains(.sun), selectedDay.contains(.sat) {
                weekendLabel.text = "주말"
            } else if selectedDay.count == 5, !selectedDay.contains(.sun), !selectedDay.contains(.sat) {
                weekendLabel.text = "주중"
            } else if selectedDay.count == 0 {
                weekendLabel.text = "미설정"
            } else {
                var text = ""
                for (index, day) in selectedDay.enumerated() {
                    text.append(index + 1 < selectedDay.count ? "\(day.localize.1), " : "\(day.localize.1)")
                }
                weekendLabel.text = text
            }
        }
    }
    private var soundIndexPath: IndexPath = IndexPath(row: 0, section: 0) {
        didSet {
            soundLabel.text = AlarmSound.allCases[soundIndexPath.row].title
        }
    }
    
    var medicine: MedicineModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        medicineInfoView.backgroundColor = horizontalGradientColor(frame: medicineInfoView.frame)
        registerButton.backgroundColor = horizontalGradientColor(frame: registerButton.frame)
        clockPickerHeaderView.backgroundColor = horizontalGradientColor(frame: clockPickerHeaderView.frame)
        
        for (index, time) in IntakeTime.allCases.enumerated() {
            let frame = CGRect(x: 0, y: 0, width: intakeStackView.frame.size.width, height: 126)
            let clockView = AlarmClockView(frame: frame)
            clockView.intakeTime = time
            clockView.isHidden = true
            clockView.clockAction = { [weak self] date in
                self?.clockPickerView.isHidden = false
                self?.clockPickerTitleLabel.text = "\(time.title) 알람"
                self?.selectedAlarmView = clockView
                self?.clockPicker.date = date
            }
            
            intakeStackView.insertArrangedSubview(clockView, at: index)
            intakeAlarmViews.append(clockView)
        }
        
        let gradient = CAGradientLayer()
        gradient.frame = self.view.frame
        gradient.colors = [UIColor(red: 0, green: 0, blue: 0, alpha: 0.8).cgColor, UIColor(red: 0, green: 0, blue: 0, alpha: 0.94).cgColor]
        gradient.startPoint = GradientDirection.vertical.startPoint
        gradient.endPoint = GradientDirection.vertical.endPoint
        clockPickerView.layer.insertSublayer(gradient, at: 0)
        clockPickerView.isHidden = true
        
        refreshView()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        super.prepare(for: segue, sender: sender)
        
        if segue.identifier == "DateSettingViewController" {
            (segue.destination as? DateSettingViewController)?.selectedDate = selectedDay
        } else if segue.identifier == "SoundSettingViewController" {
            (segue.destination as? SoundSettingViewController)?.selectedIndexPath = soundIndexPath
        }
    }
}

extension RegisterAlarmViewController: UIScrollViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let offsetY = scrollView.contentOffset.y
        if offsetY > 0 {
            sanaImageView.frame.size.height = sanaImageView.frame.height
        } else {
            sanaImageView.frame.size.height = -offsetY
        }
    }
}

extension RegisterAlarmViewController {
    private func refreshView() {
        guard let medicine = medicine else {
            return
        }
        
        medicineNameLabel.text = medicine.name
        medicineCompanyLabel.text = medicine.campanyName
        intakeGuideLabel.text = medicine.dosage
    }
}

extension RegisterAlarmViewController {
    @IBAction func tapIntakeTimeButton(_ sender: UIButton) {
        sender.isSelected = !sender.isSelected
        intakeAlarmViews[sender.tag].isHidden = !sender.isSelected
    }
    
    @IBAction func unwindeSegueFromDateSettingViewController(_ sender: UIStoryboardSegue) {
        if let vc = sender.source as? DateSettingViewController {
            selectedDay = vc.selectedDate
        }
    }
    
    @IBAction func unwindSegueFromSoundSettingViewController(_ sender: UIStoryboardSegue) {
        if let vc = sender.source as? SoundSettingViewController {
            soundIndexPath = vc.selectedIndexPath
        }
    }
    
    @IBAction func tapClockPickerCancelButton(_ sender: UIButton) {
        clockPickerView.isHidden = true
    }
    
    @IBAction func tapClockPickerConfirmButton(_ sender: UIButton) {
        clockPickerView.isHidden = true
    }
    
    @IBAction func clockPickerChanged(_ sender: UIDatePicker) {
        selectedAlarmView?.date = sender.date
    }
}
