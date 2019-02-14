//
//  DateSettingViewController.swift
//  YakGGUK
//
//  Created by Lee Junho on 09/02/2019.
//  Copyright © 2019 team1. All rights reserved.
//

import UIKit

enum Weekend: Int, CaseIterable {
    case sun = 0
    case mon
    case tue
    case wed
    case thu
    case fri
    case sat
    
    var localize: (String, String) {
        switch self {
        case .sun: return ("일요일", "일")
        case .mon: return ("월요일", "월")
        case .tue: return ("화요일", "화")
        case .wed: return ("수요일", "수")
        case .thu: return ("목요일", "목")
        case .fri: return ("금요일", "금")
        case .sat: return ("토요일", "토")
        }
    }
}

class DateSettingViewController: UIViewController {
    @IBOutlet private weak var tableView: UITableView!
    @IBOutlet private weak var completeButton: UIButton!
    
    var selectedDate: [Weekend] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        completeButton.backgroundColor = horizontalGradientColor(frame: completeButton.frame)
    }
}

extension DateSettingViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return Weekend.allCases.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "DayCell", for: indexPath)
        
        if let cell = cell as? DateSettingTableViewCell {
            cell.day = Weekend.allCases[indexPath.row]
            cell.isUserSelected = selectedDate.contains(Weekend.allCases[indexPath.row])
            cell.refreshView()
            cell.selectAction = { [weak self] day, selected in
                if selected {
                    self?.selectedDate.append(day)
                } else {
                    self?.selectedDate.removeAll(where: { $0 == day })
                }
                self?.selectedDate.sort(by: { $0.rawValue < $1.rawValue })
            }
        }
        
        return cell
    }
}

extension DateSettingViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 60
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 56
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        return tableView.dequeueReusableCell(withIdentifier: "HeaderCell")
    }
}

class DateSettingTableViewCell: UITableViewCell {
    @IBOutlet private weak var dayLabel: UILabel!
    @IBOutlet private weak var checkboxButton: UIButton!
    
    var day: Weekend?
    var isUserSelected: Bool = false
    var selectAction: ((Weekend, Bool) -> Void)?
}

extension DateSettingTableViewCell {
    func refreshView() {
        dayLabel.text = day?.localize.0
        dayLabel.textColor = isUserSelected ?  UIColor(named: "gradientLeading") : UIColor(named: "disabledText")
        checkboxButton.isSelected = isUserSelected
    }
}

extension DateSettingTableViewCell {
    @IBAction func tapCheckboxButton(_ sender: UIButton) {
        sender.isSelected = !sender.isSelected
        isUserSelected = sender.isSelected
        
        if let day = day {
            selectAction?(day, isUserSelected)
        }
        
        refreshView()
    }
}
