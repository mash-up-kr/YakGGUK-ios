//
//  SoundSettingViewController.swift
//  YakGGUK
//
//  Created by Lee Junho on 09/02/2019.
//  Copyright © 2019 team1. All rights reserved.
//

import UIKit

enum AlarmSound: String, CaseIterable {
    case basic = "default"
    
    var title: String {
        switch self {
        case .basic: return "기본"
        }
    }
}

class SoundSettingViewController: UIViewController {
    @IBOutlet private weak var tableView: UITableView!
    @IBOutlet private weak var completeButton: UIButton!
    
    var selectedIndexPath: IndexPath = IndexPath(row: 0, section: 0)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        completeButton.backgroundColor = horizontalGradientColor(frame: completeButton.frame)
    }
}

extension SoundSettingViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return AlarmSound.allCases.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "SoundCell", for: indexPath)
        
        (cell as? SoundSettingTableViewCell)?.reloadItem(with: AlarmSound.allCases[indexPath.row],
                                                         isUserSelected: indexPath == selectedIndexPath)
        
        return cell
    }
}

extension SoundSettingViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 60
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 44
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        return tableView.dequeueReusableCell(withIdentifier: "HeaderCell")
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let previousCell = tableView.cellForRow(at: selectedIndexPath) as? SoundSettingTableViewCell
        previousCell?.reloadItem(with: AlarmSound.allCases[selectedIndexPath.row], isUserSelected: false)
        
        let selectedCell = tableView.cellForRow(at: indexPath) as? SoundSettingTableViewCell
        selectedCell?.reloadItem(with: AlarmSound.allCases[indexPath.row], isUserSelected: true)
        
        selectedIndexPath = indexPath
    }
}

class SoundSettingTableViewCell: UITableViewCell {
    @IBOutlet private weak var titleLabel: UILabel!
    @IBOutlet private weak var checkMarkImageView: UIImageView!
    
    private var sound: AlarmSound?
    private var isUserSelected: Bool = false {
        didSet {
            checkMarkImageView.isHidden = !isUserSelected
        }
    }
}

extension SoundSettingTableViewCell {
    func reloadItem(with sound: AlarmSound, isUserSelected: Bool) {
        self.sound = sound
        self.isUserSelected = isUserSelected
        
        titleLabel.text = sound.title
    }
}
