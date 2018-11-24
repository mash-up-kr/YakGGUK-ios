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
    var alarms: [String] = []
    @IBOutlet weak var alarmTableView: UITableView!
    
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

extension RegisterAlarmViewController : UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "alarm_cell", for: indexPath) as? AlarmTableViewCell else {
            
            return AlarmTableViewCell()
        }
        
        return cell
    }
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 120
    }
}

extension RegisterAlarmViewController: CheckBoxButtonDeleagate {
    func actionButtonClicked(_ checked : Bool, _ title : String) {
        if checked {
            alarms.append(title)
        } else if let item = alarms.firstIndex(of: title) {
            alarms.remove(at: item)
        }
        self.alarmTableView.reloadData()
    }
    
}
