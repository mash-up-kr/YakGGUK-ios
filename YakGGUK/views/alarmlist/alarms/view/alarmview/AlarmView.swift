//
//  AlarmView.swift
//  YakGGUK
//
//  Created by 김선재 on 31/12/2018.
//  Copyright © 2018 team1. All rights reserved.
//

import UIKit

class AlarmView: UIView {
    
    weak var tableViewDelegate: UITableViewDelegate?
    weak var tableViewDataSource: UITableViewDataSource?
    
    private var didUpdateConstraints = false
    
    private var imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = #imageLiteral(resourceName: "symbolMini")
        
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    public lazy var tableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .grouped)
        
        tableView.separatorStyle = .none
        tableView.register(AlarmListTableViewCell.self, forCellReuseIdentifier: "alarmlist")
        
        // FIXME: Delegate, DataSource 동기화 시키기
//        tableView.delegate          = self.tableViewDelegate
//        tableView.dataSource        = self.tableViewDataSource
        
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
                imageView.widthAnchor.constraint(equalToConstant: 78.0),
                imageView.heightAnchor.constraint(equalToConstant: 45.0)
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

}
