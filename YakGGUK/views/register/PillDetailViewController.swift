//
//  PillDetailViewController.swift
//  YakGGUK
//
//  Created by juhee on 15/02/2019.
//  Copyright © 2019 team1. All rights reserved.
//

import UIKit

class PillDetailViewController: UIViewController {

    @IBOutlet weak var detailTableView: UITableView!
    @IBOutlet weak var confirmButton: UIButton!
    
    private var pill: Pill!
    private let reuseIdentifier: String = "pill_detail_cell"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        pill = Pill(name: "광동제약품", companyName: "광동", apperance: "물약", content: "코감기, 목감기, 몸살 감기 완화", intake: "1일 2회, 1회 2캡슐", precautions: "식전 식후 주의사항\n알레르기 주의사항\n주의사항 지켜라 주의사항 지켜라", expirationDate: "2019-12-12")

        setGradient()
    }
    
    private func setGradient() {
        setHorizontalGradientLayer()
        if let headerView = detailTableView.tableHeaderView {
            headerView.backgroundColor = horizontalGradientColor(frame: headerView.frame)
        }
        confirmButton.backgroundColor = horizontalGradientColor(frame: confirmButton.frame)
    }

    func bind(pill product: Pill) {
        pill = product
    }
}

extension PillDetailViewController {
    
    @IBAction func didTapBackButton(_ sender: Any) {
        navigationController?.popViewController(animated: true)
    }
}

extension PillDetailViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 8
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.row == 7 {
            return UITableViewCell()
        } else {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: reuseIdentifier, for: indexPath)
                as? PillDetailTableViewCell
                else {
                    preconditionFailure("Couldn't dequeue reusabel cell with identifier : \(reuseIdentifier)")
            }
            guard let type = PillDetailCellType(rawValue: indexPath.row) else {
                preconditionFailure("Couldn't get PillDetailCellType for row : \(indexPath.row)")
            }
            cell.bind(title: type.title, info: pill.info(type: type))
            return cell
        }
    }
}

extension PillDetailViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 300
    }
}
