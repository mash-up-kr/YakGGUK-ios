import UIKit
import Floaty

class AlarmViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    var alarms: [AlarmModel] = []
    
    @IBOutlet weak var MyPageImage: UIImageView!
    @IBOutlet var gestureMyPage: UITapGestureRecognizer!
    
    let floaty = Floaty()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        alarms.append(AlarmModel(eWhen: .WAKEUP, eWhenType: .AFTER, time: "07 : 00", medicines: [
            MedicineModel(name: "오르나민 C", description: "1회 125ml 섭취"),
            MedicineModel(name: "홍삼 골드", description: "1회 100ml 섭취")
        ]))
        
        alarms.append(AlarmModel(eWhen: .MORNING, eWhenType: .AFTER, time: "09 : 00", medicines: [
            MedicineModel(name: "오메가3", description: "1회 1알 섭취"),
            MedicineModel(name: "단백질 보충제", description: "1회 2알 섭취")
        ]))
        
        alarms.append(AlarmModel(eWhen: .DINNER, eWhenType: .AFTER, time: "19 : 00", medicines: []))
        
        alarms.append(AlarmModel(eWhen: .NIGHT, eWhenType: .BEFORE, time: "23 : 30", medicines: [
            MedicineModel(name: "수면 유도제", description: "1회 1알 섭취")
        ]))
        
        tableView.separatorStyle = .none
        tableView.allowsSelection = false
        
        tableView.dataSource = self
        tableView.delegate = self
        
        floaty.addItem(title: "추가하기") { _ in
            let alert = UIAlertController(title: "[알림]", message: "아직 미구현된 기능입니다.", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "확인", style: .default, handler: nil))
            self.present(alert, animated: true, completion: nil)
            self.floaty.close()
        }
        
        self.view.addSubview(floaty)
    }
}

extension AlarmViewController {
    
    @IBAction func tapGesutreAction() {
            let alert = UIAlertController(title: "[알림]", message: "아직 미구현된 기능입니다.", preferredStyle: .alert)
            let okAction = UIAlertAction(title: "확인", style: .default, handler: nil)
            
            alert.addAction(okAction)
            
            present(alert, animated: true)
    }
    
}

extension AlarmViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if alarms.count == 0 {
            return 268.0
        } else {
            if (indexPath.row % 2 == 1) {
                if let cell = tableView.cellForRow(at: IndexPath(row: indexPath.row - 1, section: indexPath.section)) as? AlarmCell {
                    
                    if cell.isExpand {
                        if let cell = tableView.cellForRow(at: indexPath) as? AlarmDetailCell {
                            return CGFloat(10.0 + Double(cell.medicines.count) * 120.0)
                        }
                    }
                }
            } else {
                return 82.0
            }
        }
            
        return 0.0
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return alarms.count == 0 ? 1 : alarms.count * 2
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var detailBool: Bool = false
        
        if alarms.count == 0 {
            if let cell = tableView.dequeueReusableCell(withIdentifier: "noalarmcell", for: indexPath) as? NoAlarmCell {

                cell.delegate = self

                return cell
            }
        } else if (alarms.count % 2 == 0) {
            if let cell = tableView.dequeueReusableCell(withIdentifier: "alarmcell", for: indexPath) as? AlarmCell {
                
                cell.setWhen(alarms[indexPath.row / 2].eWhen)
                cell.setTime(alarms[indexPath.row / 2].time)
                
                cell.delegate = self
                
                return cell
            }
        } else {
            if let cell = tableView.dequeueReusableCell(withIdentifier: "detailalarmcell", for: indexPath) as? AlarmDetailCell {
                
                cell.medicines = alarms[indexPath.row / 2].medicines
                cell.delegate = self
                
                return cell
            }
        }
        
        return UITableViewCell()
    }
    
}

extension AlarmViewController: AddAlarmButtonDelegate {
    func buttonPressed(_ cell: NoAlarmCell) {
        let alert = UIAlertController(title: "[알림]", message: "아직 미구현된 기능입니다.", preferredStyle: .alert)
        let okAction = UIAlertAction(title: "확인", style: .default, handler: nil)
        
        alert.addAction(okAction)
        
        present(alert, animated: true)
    }
}

extension AlarmViewController: AlarmButtonDelegate {
    func buttonPressed(_ cell: AlarmCell) {
        if !cell.isExpand {
            cell.setExpand()
        } else {
            cell.setCollapse()
        }
        
        tableView.reloadData()
    }
}

extension AlarmViewController: PresentAlertDelegate {
    func showAlertController(_ alert: UIAlertController) {
        let alert = UIAlertController(title: "[알림]", message: "아직 미구현된 기능입니다.", preferredStyle: .alert)
        let okAction = UIAlertAction(title: "확인", style: .default, handler: nil)
        
        alert.addAction(okAction)
        
        present(alert, animated: true)
    }
}
