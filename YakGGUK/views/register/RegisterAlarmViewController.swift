//
//  RegisterAlarmViewController.swift
//  YakGGUK
//
//  Created by juhee on 2018. 11. 25..
//  Copyright © 2018년 team1. All rights reserved.
//

import UIKit

class RegisterAlarmViewController: UIViewController {
    
    var medicineName: String!
    var medicineDescript: String!
    var alarms: [(String, Date)] = []
    var indexForChange: Int = 0
    
    let timeFormatter: DateFormatter = {
        let format = DateFormatter()
        format.locale = Locale.current
        format.timeStyle = DateFormatter.Style.short
        return format
    }()
    
    @IBOutlet weak var alarmTableView: UITableView!
    @IBOutlet weak var pickerView: UIView!
    @IBOutlet weak var timePiker: UIDatePicker!
    
    @IBOutlet weak var morningButton: CheckBoxButton!
    @IBOutlet weak var afternoonButton: CheckBoxButton!
    @IBOutlet weak var nightButton: CheckBoxButton!
    @IBOutlet weak var bedroonButton: CheckBoxButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        morningButton.buttonDelegate = self
        afternoonButton.buttonDelegate = self
        nightButton.buttonDelegate = self
        bedroonButton.buttonDelegate = self
    }
    
}

// MARK: - IBActions
extension RegisterAlarmViewController {
    @IBAction func registerAlarm(_ sender: UIButton) {
        guard self.alarms.count > 0 else {
            let alertVC = UIAlertController(title: "알람을 등록하세요", message: nil, preferredStyle: .alert)
            alertVC.addAction(UIAlertAction(title: "확인", style: .cancel, handler: nil))
            self.present(alertVC, animated: true)
            return
        }
        // TODO: 알람 등록하기
        self.navigationController?.addBottomDismissTransition()
        self.navigationController?.dismiss(animated: false, completion: nil)
        
    }
    
    @IBAction func hideTimer(_ sender: UITapGestureRecognizer) {
        self.pickerView.isHidden = true
    }
    @IBAction func changeAlarmTime(_ sender: UIBarButtonItem) {
        self.pickerView.isHidden = true
        self.alarms[indexForChange].1 = self.timePiker.date
        self.alarmTableView.reloadData()
    }
}

extension RegisterAlarmViewController : UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return alarms.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "alarm_cell", for: indexPath) as? AlarmTableViewCell else {
            
            return AlarmTableViewCell()
        }
        let alarm = alarms[indexPath.row]
        cell.titleLabel.text = alarm.0
        cell.timeLabel.text = timeFormatter.string(from: alarm.1)
        return cell
    }
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 120
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: false)
        self.indexForChange = indexPath.row
        self.pickerView.isHidden = false
    }
}

extension RegisterAlarmViewController: CheckBoxButtonDeleagate {
    func actionButtonClicked(_ checked : Bool, _ title : String) {
        if checked {
            alarms.append((title, Date()))
        } else if let item = alarms.firstIndex(where: {$0.0 == title}) {
            alarms.remove(at: item)
        }
        self.alarmTableView.reloadData()
    }
}
