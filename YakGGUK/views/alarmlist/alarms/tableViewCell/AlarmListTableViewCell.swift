//
//  alarmTableViewCell.swift
//  YakGGUK
//
//  Created by 김선재 on 01/01/2019.
//  Copyright © 2019 team1. All rights reserved.
//

import UIKit

protocol AlarmListActionDelegate: class {
    func editAction(_ sender: UIButton, cell: AlarmListTableViewCell)
    func collapseAction(_ sender: UIButton, cell: AlarmListTableViewCell)
}

class AlarmListTableViewCell: UITableViewCell {

    private weak var actionDelegate: AlarmListActionDelegate?
    
    private var didUpdateConstraints = false
    
    private var bgView: UIView = {
        let view = UIView()
        
        view.backgroundColor = UIColor.white
        
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
        label.font          = UIFont(name: "AppleSDGothicNeo-Medium", size: 20.0)
        
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
        label.font          = UIFont(name: "AppleSDGothicNeo-Light", size: 34.0)
        
        label.letterSpacing = 0.36
        
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var editButton: UIButton = {
        let button = UIButton()
        
        button.setImage(#imageLiteral(resourceName: "icEdit"), for: .normal)
        
        button.addTarget(self, action: #selector(editButtonAction), for: .touchUpInside)
        
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private lazy var collapseButton: UIButton = {
        let button = UIButton()
        
        button.setImage(#imageLiteral(resourceName: "icDown"), for: .normal)
        
        button.addTarget(self, action: #selector(collapseButtonAction), for: .touchUpInside)
        
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private lazy var medicineTableView: UITableView = {
        let tableView = UITableView.init(frame: .zero, style: .grouped)
        
        tableView.delegate     = self
        tableView.dataSource   = self
        
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        selectionStyle = .none
        
        self.backgroundColor = UIColor.clear
        bgView.layer.cornerRadius = 6.0
        bgView.layer.masksToBounds = false
        bgView.layer.shadowColor = UIColor.init(named: "sapphire")?.cgColor ?? UIColor.black.cgColor
        bgView.layer.shadowOffset = CGSize(width: 0, height: 2)
        bgView.layer.shadowOpacity = 0.8
        
        bgView.addSubview(ampmLabel)
        bgView.addSubview(whenLabel)
        bgView.addSubview(timeLabel)
        bgView.addSubview(editButton)
        bgView.addSubview(collapseButton)
        bgView.addSubview(medicineTableView)
        
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
                bgView.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -4.0)
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
                editButton.centerYAnchor.constraint(equalTo: bgView.centerYAnchor),
                editButton.trailingAnchor.constraint(equalTo: collapseButton.leadingAnchor, constant: -17.0),
                editButton.widthAnchor.constraint(equalToConstant: 32.0),
                editButton.heightAnchor.constraint(equalToConstant: 32.0)
            ])
            
            NSLayoutConstraint.activate([
                medicineTableView.leadingAnchor.constraint(equalTo: bgView.leadingAnchor),
                medicineTableView.trailingAnchor.constraint(equalTo: bgView.trailingAnchor),
                medicineTableView.topAnchor.constraint(equalTo: bgView.bottomAnchor),
                medicineTableView.heightAnchor.constraint(equalToConstant: 0.0)
            ])
            
            didUpdateConstraints.toggle()
        }
        
        super.updateConstraints()
    }
    
    @objc private func editButtonAction(sender: UIButton!) {
        actionDelegate?.editAction(sender, cell: self)
    }
    
    @objc private func collapseButtonAction(sender: UIButton!) {
        actionDelegate?.collapseAction(sender, cell: self)
    }
    
    public func setActionDelegate(_ delegate: AlarmListActionDelegate) {
        actionDelegate = delegate
    }
    
    public func setFormattedAlarm(alarm model: AlarmModel) {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "HH : mm"
        
        let optDate = dateFormatter.date(from: model.time)
        
        dateFormatter.dateFormat = "a"
        dateFormatter.amSymbol = "오전"
        dateFormatter.pmSymbol = "오후"
        
        if let date = optDate {
            let ampm = dateFormatter.string(from: date)
            ampmLabel.text = ampm
        }
        
        whenLabel.text = model.eWhen.description()
        timeLabel.text = model.time
        
        // TODO: 서브 테이블 뷰 데이터 로드
    }
    
}

// TODO: 서브 테이블 뷰 메소드 구현하기
extension UITableViewCell: UITableViewDelegate, UITableViewDataSource {
    public func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100.0
    }
    
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 0
    }
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return UITableViewCell()
    }
}
