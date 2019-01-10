import UIKit
import Floaty

class AlarmViewController: UIViewController {
    
    var didUpdateConstraints = false
    
    let floaty = Floaty()
    
    let alarmView = AlarmView()
    
    let noAlarmView = NoAlarmView()
    
    var alarms: [AlarmModel] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setVerticalGradientLayer()
        
        initFloaty()
        
        alarms.append(AlarmModel(eWhen: .WAKEUP, time: "07 : 00", medicines: [
            MedicineModel(name: "오르나민 C", description: "1회 125ml 섭취"),
            MedicineModel(name: "홍삼 골드", description: "1회 100ml 섭취"),
            MedicineModel(name: "오르나민 C", description: "1회 125ml 섭취"),
            MedicineModel(name: "홍삼 골드", description: "1회 100ml 섭취")
        ]))
        
        alarms.append(AlarmModel(eWhen: .MORNING, time: "09 : 00", medicines: [
            MedicineModel(name: "오메가3", description: "1회 1알 섭취"),
            MedicineModel(name: "단백질 보충제", description: "1회 2알 섭취")
        ]))
        
        alarms.append(AlarmModel(eWhen: .DINNER, time: "19 : 00", medicines: [
            MedicineModel(name: "단백질 보충제", description: "1회 2알 섭취")]))
        
        alarms.append(AlarmModel(eWhen: .NIGHT, time: "23 : 30", medicines: [
            MedicineModel(name: "수면 유도제", description: "1회 1알 섭취")
        ]))
        
        if alarms.isEmpty {
            alarmView.isHidden = true
        } else {
            noAlarmView.isHidden = true
        }
        
        alarmView.setTableViewProtocol(delegate: self, dataSource: self)
        alarmView.setTableViewStyle(sepStyle: .none, bgColor: .clear)
        
        view.addSubview(noAlarmView)
        view.addSubview(alarmView)
        
        view.updateConstraintsIfNeeded()
    }
    
    override func updateViewConstraints() {
        if !didUpdateConstraints {
            
            NSLayoutConstraint.activate([
                noAlarmView.topAnchor.constraint(equalTo: view.topAnchor),
                noAlarmView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
                noAlarmView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
                noAlarmView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
            ])
            
            NSLayoutConstraint.activate([
                alarmView.topAnchor.constraint(equalTo: view.topAnchor),
                alarmView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
                alarmView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
                alarmView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
            ])
            
            didUpdateConstraints.toggle()
        }
        
        super.updateViewConstraints()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
    }
}

// MARK: - 플로팅 버튼
extension AlarmViewController {
    func initFloaty() {
        floaty.addItem(title: "추가하기") { _ in
            guard let nextVC = UIStoryboard(name: "Search", bundle: nil).instantiateViewController(withIdentifier: "barcode_scan") as? BarcodeScanViewController else {
                print("[navigation Error]")
                return
            }
            let naviVC = UINavigationController(rootViewController: nextVC)
            naviVC.navigationBar.isTranslucent = true
            naviVC.view.backgroundColor = UIColor.clear
            naviVC.addBottomAppearTransition()
            self.present(naviVC, animated: false, completion: nil)
            self.floaty.close()
        }
        
        floaty.plusColor = UIColor(named: "gradientLeading") ?? UIColor.purple
        floaty.buttonColor = UIColor.white
        
        floaty.layer.zPosition = 1000
        
        view.addSubview(floaty)
    }
}

// MARK: - 알람 테이블뷰
extension AlarmViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if let cell = tableView.cellForRow(at: indexPath) as? AlarmListTableViewCell {
            if cell.isCollapsed() {
                return 90.0 + (4.0 * 2) + ( (110.0 * CGFloat(cell.countMedicines())) > 275.0 ? 275.0 : (110.0 * CGFloat(cell.countMedicines())) )
            }
        }
        
        return 90.0 + (4.0 * 2)
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 0.0
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 20.0 - 4.0 * 2
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        return UIView()
    }
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        return UIView()
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return alarms.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "alarmlist", for: indexPath) as? AlarmListTableViewCell else {
            return UITableViewCell()
        }
        
        cell.setFormattedAlarm(alarm: alarms[indexPath.section])
        
        cell.setActionDelegate(self)
        
        return cell
    }
}

// MARK: - 알람 리스트 뷰 셀 액션 위임
extension AlarmViewController: AlarmListActionDelegate {
    func editAction(_ sender: UIButton, cell: AlarmListTableViewCell) {
        let alert = UIAlertController(title: "[알림]", message: "아직 미구현 된 기능입니다.", preferredStyle: .alert)
        
        alert.addAction(UIAlertAction(title: "확인", style: .cancel, handler: nil))
        
        self.present(alert, animated: true, completion: nil)
    }
    
    func collapseAction(_ sender: UIButton, cell: AlarmListTableViewCell) {
        alarmView.updateTableViewData()
    }
}
