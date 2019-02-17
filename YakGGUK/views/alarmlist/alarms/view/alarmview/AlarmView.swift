//
//  AlarmView.swift
//  YakGGUK
//
//  Created by 김선재 on 31/12/2018.
//  Copyright © 2018 team1. All rights reserved.
//

import UIKit

class AlarmView: UIView {
    
    private weak var tableViewDelegate: UITableViewDelegate?
    private weak var tableViewDataSource: UITableViewDataSource?
    
    private var didUpdateConstraints = false
    
    private var imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = #imageLiteral(resourceName: "symbolMini")
        
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private var tableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .grouped)
        
        tableView.register(AlarmListTableViewCell.self, forCellReuseIdentifier: "alarmlist")
        
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.translatesAutoresizingMaskIntoConstraints = false
        
        addSubview(imageView)
        addSubview(tableView)
        setNeedsUpdateConstraints()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder: ) not been implemented")
    }
    
    override func updateConstraints() {
        if !didUpdateConstraints {
            
            NSLayoutConstraint.activate([
                imageView.topAnchor.constraint(equalTo: self.topAnchor, constant: 57.0),
                imageView.centerXAnchor.constraint(equalTo: self.centerXAnchor),
                imageView.widthAnchor.constraint(equalToConstant: 84.0),
                imageView.heightAnchor.constraint(equalToConstant: 47.0)
            ])
            
            NSLayoutConstraint.activate([
                tableView.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 31.0),
                tableView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
                tableView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
                tableView.bottomAnchor.constraint(equalTo: self.bottomAnchor)
            ])
            
            didUpdateConstraints.toggle()
        }
        
        super.updateConstraints()
    }

    public func setTableViewStyle(sepStyle: UITableViewCell.SeparatorStyle, bgColor: UIColor) {
        tableView.separatorStyle    = sepStyle
        tableView.backgroundColor   = bgColor
    }
    
    public func setTableViewProtocol(delegate: UITableViewDelegate, dataSource: UITableViewDataSource) {
        tableView.delegate      = delegate
        tableView.dataSource    = dataSource
    }
    
    public func updateTableViewData() {
        tableView.beginUpdates()
        tableView.endUpdates()
    }
    
}
