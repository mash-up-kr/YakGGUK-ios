//
//  alarmTableViewCell.swift
//  YakGGUK
//
//  Created by 김선재 on 01/01/2019.
//  Copyright © 2019 team1. All rights reserved.
//

import UIKit
import Foundation

protocol AlarmListActionDelegate: class {
    func collapseAction(_ sender: UIButton, cell: AlarmListTableViewCell)
}

enum FadeType: Int {
    case fadeout = 0
    case fadein
}

// TODO: Collapse 시 페이드 기능 추가하기
protocol AlarmListFadeDelegate: class {
    func fade(indexPath: IndexPath, fadeType: FadeType)
}

protocol MedicineListActionDelegate: class {
    func editAction(_ sender: UITableViewRowAction, indexPath: IndexPath, completion: @escaping (IndexPath) -> Void)
    func deleteAction(_ sender: UITableViewRowAction, indexPath: IndexPath, completion: @escaping (IndexPath) -> Void)
}

class AlarmListTableViewCell: UITableViewCell {

    private weak var actionDelegate: AlarmListActionDelegate?
    
    private weak var fadeDelegate: AlarmListFadeDelegate?
    
    private weak var medicineActionDelegate: MedicineListActionDelegate?
    
    private var didUpdateConstraints = false
    
    private var medicineCollapsable = false
    
    private var medicines: [MedicineModel] = []
    
    private var bgView: UIView = {
        let view = UIView()
        
        view.backgroundColor = UIColor.white
        
        view.layer.cornerRadius = 6.0
        view.layer.masksToBounds = false
        view.layer.shadowColor = UIColor.init(named: "sapphire")?.cgColor ?? UIColor.black.cgColor
        view.layer.shadowOffset = CGSize(width: 0, height: 2)
        view.layer.shadowOpacity = 0.8
        
        view.layer.zPosition = 999
        
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private var medicineBgView: UIView = {
        let view = UIView()
        
        view.backgroundColor = UIColor.white
        
        view.layer.cornerRadius = 6.0
        view.layer.masksToBounds = false
        view.layer.shadowColor = UIColor.init(named: "sapphire")?.cgColor ?? UIColor.black.cgColor
        view.layer.shadowOffset = CGSize(width: 0, height: 2)
        view.layer.shadowOpacity = 0.8
        
        view.layer.zPosition = 998
        
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private var ampmLabel: UILabel = {
        let label = UILabel()
        let text = "오전"
        
        label.text          = text
        
        label.lineBreakMode = .byWordWrapping
        label.numberOfLines = 1
        
        label.textAlignment = .center
        label.textColor     = UIColor(named: "gradientLeading")
        label.font          = UIFont(name: "AppleSDGothicNeo-Medium", size: 14.0)
        
        label.letterSpacing = 0.21
        
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private var whenLabel: UILabel = {
        let label = UILabel()
        let text = "기상"
        
        label.text          = text
        
        label.lineBreakMode = .byWordWrapping
        label.numberOfLines = 1
        
        label.textAlignment = .center
        label.textColor     = UIColor(red: 79 / 255, green: 79 / 255, blue: 79 / 255, alpha: 1.0)
        label.font          = UIFont(name: "AppleSDGothicNeo-Light", size: 20.0)
        
        label.letterSpacing = 0.21
        
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private var timeLabel: UILabel = {
        let label = UILabel()
        let text = "00 : 00"
        
        label.text          = text
        
        label.lineBreakMode = .byWordWrapping
        label.numberOfLines = 1
        
        label.textAlignment = .center
        label.textColor     = UIColor(red: 59 / 255, green: 59 / 255, blue: 59 / 255, alpha: 1.0)
        label.font          = UIFont(name: "SFProDisplay-Medium", size: 32.0)
        
        label.letterSpacing = 0.34
        
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var collapseButton: UIButton = {
        let button = UIButton()
        
        button.setImage(#imageLiteral(resourceName: "icDown"), for: .normal)
        
        button.addTarget(self, action: #selector(collapseButtonAction), for: .touchUpInside)
        
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private lazy var medicineTableView: UITableView = {
        let tableView = UITableView.init(frame: .zero, style: .plain)
        
        tableView.delegate     = self
        tableView.dataSource   = self
        
        tableView.register(MedicineTableViewCell.self, forCellReuseIdentifier: "medicine")
        
        tableView.separatorStyle    = .none
        
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        selectionStyle = .none
        
        self.backgroundColor = UIColor.clear
        
        bgView.addSubview(ampmLabel)
        bgView.addSubview(whenLabel)
        bgView.addSubview(timeLabel)
        bgView.addSubview(collapseButton)
        
        medicineBgView.addSubview(medicineTableView)
        
        contentView.addSubview(medicineBgView)
        contentView.addSubview(bgView)
        
        contentView.setNeedsUpdateConstraints()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder: ) not been implemented")
    }
    
    override func updateConstraints() {
        if !didUpdateConstraints {
            
            NSLayoutConstraint.activate([
                bgView.topAnchor.constraint(equalTo: self.topAnchor, constant: 4.0),
                bgView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 24.0),
                bgView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -24.0),
                bgView.heightAnchor.constraint(equalToConstant: 90.0 - 4.0)
            ])
            
            NSLayoutConstraint.activate([
                medicineBgView.topAnchor.constraint(equalTo: self.topAnchor, constant: 4.0),
                medicineBgView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 24.0),
                medicineBgView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -24.0)
            ])
            
            NSLayoutConstraint.activate([
                ampmLabel.topAnchor.constraint(equalTo: bgView.topAnchor, constant: 25.0),
                ampmLabel.leadingAnchor.constraint(equalTo: bgView.leadingAnchor, constant: 20.0)
            ])
            
            NSLayoutConstraint.activate([
                whenLabel.topAnchor.constraint(equalTo: ampmLabel.topAnchor, constant: 16.0),
                whenLabel.leadingAnchor.constraint(equalTo: ampmLabel.leadingAnchor)
            ])
            
            NSLayoutConstraint.activate([
                timeLabel.topAnchor.constraint(equalTo: bgView.topAnchor, constant: 25.0),
                timeLabel.leadingAnchor.constraint(equalTo: bgView.leadingAnchor, constant: 72.0)
            ])
            
            NSLayoutConstraint.activate([
                collapseButton.centerYAnchor.constraint(equalTo: bgView.centerYAnchor),
                collapseButton.trailingAnchor.constraint(equalTo: bgView.trailingAnchor, constant: -20.0),
                collapseButton.widthAnchor.constraint(equalToConstant: 32.0),
                collapseButton.heightAnchor.constraint(equalToConstant: 32.0)
            ])
            
            NSLayoutConstraint.activate([
                medicineTableView.leadingAnchor.constraint(equalTo: medicineBgView.leadingAnchor),
                medicineTableView.trailingAnchor.constraint(equalTo: medicineBgView.trailingAnchor),
                medicineTableView.topAnchor.constraint(equalTo: medicineBgView.topAnchor, constant: 90.0 - 4.0 - 1.0)
            ])
            
            let medicineBgHeightConstraint = medicineBgView.heightAnchor.constraint(equalToConstant: 90.0 - 4.0)
            medicineBgHeightConstraint.identifier = "heightConstraint"
            medicineBgHeightConstraint.isActive = true
            
            let medicineTbHeightConstraint = medicineTableView.heightAnchor.constraint(equalToConstant: 0.0)
            medicineTbHeightConstraint.identifier = "heightConstraint"
            medicineTbHeightConstraint.isActive = true
            
            didUpdateConstraints.toggle()
        }
        
        super.updateConstraints()
    }
    
    @objc private func collapseButtonAction(sender: UIButton!) {
        toggleCollapsable()
        
        if isCollapsed() {
            collapseButton.setImage(#imageLiteral(resourceName: "icUp"), for: .normal)
            if let constraint = medicineBgView.constraints.filter({ $0.identifier == "heightConstraint" }).first {
                if Double(medicines.count) * 110.0 > 275.0 {
                    constraint.constant = 90.0 - 4.0 + 275.0
                } else {
                    constraint.constant = 90.0 - 4.0 + CGFloat(Double(medicines.count) * 110.0)
                }
            }
            
            if let constraint = medicineTableView.constraints.filter({ $0.identifier == "heightConstraint" }).first {
                if Double(medicines.count) * 110.0 > 275.0 {
                    constraint.constant = 275.0 - 5.0
                } else {
                    constraint.constant = CGFloat(Double(medicines.count) * 110.0) - 5.0
                }
            }
        } else {
            collapseButton.setImage(#imageLiteral(resourceName: "icDown"), for: .normal)
            if let constraint = medicineBgView.constraints.filter({ $0.identifier == "heightConstraint" }).first {
                constraint.constant = 90.0 - 4.0
            }
            
            if let constraint = medicineTableView.constraints.filter({ $0.identifier == "heightConstraint" }).first {
                constraint.constant = 0.0
            }
        }
        
        UIView.animate(withDuration: 0.3) {
            self.layoutIfNeeded()
        }
        
        actionDelegate?.collapseAction(sender, cell: self)
    }
    
    public func setActionDelegate(alarmDelegate: AlarmListActionDelegate, medicineDelegate: MedicineListActionDelegate) {
        actionDelegate = alarmDelegate
        medicineActionDelegate = medicineDelegate
    }
    
    public func setFormattedAlarm(alarm model: AlarmModel) {
        
        ampmLabel.text = model.alarmTime.mAmpm.rawValue
        whenLabel.text = model.eWhen.description()
        timeLabel.text = String(format: "%02d : %02d", arguments: [model.alarmTime.mHour, model.alarmTime.mMinute])
        
        medicines = model.medicines
        medicineTableView.reloadData()
    }
    
    public func updateMedicineTable() {
        medicineTableView.reloadData()
    }
    
    public func toggleCollapsable() {
        medicineCollapsable.toggle()
    }
    
    public func isCollapsed() -> Bool {
        return medicineCollapsable
    }
    
    public func countMedicines() -> Int {
        return medicines.count
    }
    
}

// MARK: - 약 테이블뷰
extension AlarmListTableViewCell: UITableViewDelegate, UITableViewDataSource {
    public func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 110.0
    }
    
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return medicines.count
    }
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = medicineTableView.dequeueReusableCell(withIdentifier: "medicine", for: indexPath) as? MedicineTableViewCell else {
            return UITableViewCell()
        }
        
        let index = indexPath.row
        cell.setTitle(title: medicines[index].name)
        cell.setDescription(description: medicines[index].description)
        
        // TODO: 이미지 설정
        
        return cell
    }
}

// MARK: - 약 테이블뷰 액션 정의
extension AlarmListTableViewCell {
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
        
        let deleteAction = UITableViewRowAction(style: .default, title: "삭제") { sender, indexPath  in
            self.medicineActionDelegate?.deleteAction(sender, indexPath: indexPath) { _ in
                self.medicines.remove(at: indexPath.row)
                self.medicineTableView.deleteRows(at: [indexPath], with: .automatic)
            }
        }
        
        let editAction = UITableViewRowAction(style: .normal, title: "수정") { sender, indexPath  in
            self.medicineActionDelegate?.editAction(sender, indexPath: indexPath) { _ in
                
            }
        }
        
        return [deleteAction, editAction]
    }
}
