import UIKit
import Floaty

class AlarmViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var noAlertView: UIView!
    
    var alarms: [AlarmModel] = []
    
    @IBOutlet weak var myPageImage: UIImageView!
    @IBOutlet var gestureMyPage: UITapGestureRecognizer!
    
    let floaty = Floaty()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setBackgroundGradientLayer()
        alarms.append(AlarmModel(eWhen: .WAKEUP, eWhenType: .AFTER, time: "07 : 00", medicines: [
            MedicineModel(name: "오르나민 C", description: "1회 125ml 섭취"),
            MedicineModel(name: "홍삼 골드", description: "1회 100ml 섭취"),
            MedicineModel(name: "오르나민 C", description: "1회 125ml 섭취"),
            MedicineModel(name: "홍삼 골드", description: "1회 100ml 섭취")
        ]))

        alarms.append(AlarmModel(eWhen: .MORNING, eWhenType: .AFTER, time: "09 : 00", medicines: [
            MedicineModel(name: "오메가3", description: "1회 1알 섭취"),
            MedicineModel(name: "단백질 보충제", description: "1회 2알 섭취")
        ]))

        alarms.append(AlarmModel(eWhen: .DINNER, eWhenType: .AFTER, time: "19 : 00", medicines: [
            MedicineModel(name: "단백질 보충제", description: "1회 2알 섭취")]))

        alarms.append(AlarmModel(eWhen: .NIGHT, eWhenType: .BEFORE, time: "23 : 30", medicines: [
            MedicineModel(name: "수면 유도제", description: "1회 1알 섭취")
        ]))
        
        tableView.separatorStyle = .none
        tableView.allowsSelection = false
        tableView.dataSource = self
        tableView.delegate = self
        
        floaty.addItem(title: "추가하기") { _ in
            guard let nextVC = UIStoryboard(name: "Search", bundle: nil).instantiateViewController(withIdentifier: "barcode_scan") as? BarcodeScanViewController else {
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
        
        self.view.addSubview(floaty)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        noAlertView.isHidden = !alarms.isEmpty
    }
}

extension AlarmViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        // AlarmDetailCell
        if (indexPath.row % 2 == 1) {
            let alarm = alarms[indexPath.row / 2]
            if alarm.isExpand {
                return min(CGFloat(10.0 + Double(alarm.medicines.count) * 110.0), 275)
            } else {
                return 0
            }
        }
        // AlarmCell
        return 110.0
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return alarms.count * 2
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // 짝수 셀이 AlarmCell
        if (indexPath.row % 2 == 0) {
            if let cell = tableView.dequeueReusableCell(withIdentifier: "alarmcell", for: indexPath) as? AlarmCell {
                
                cell.setId(indexPath.row / 2)
                cell.setWhen(alarms[indexPath.row / 2].eWhen)
                cell.setTime(alarms[indexPath.row / 2].time)
                cell.setDelegate(self)
                cell.setEditDelegate(self)
                
                return cell
            }
        } else {
            if let cell = tableView.dequeueReusableCell(withIdentifier: "detailalarmcell", for: indexPath) as? AlarmDetailCell {
                
                cell.setMedicines(alarms[indexPath.row / 2].medicines)
                cell.setDelegate(self)
                
                return cell
            }
        }
        
        return UITableViewCell()
    }
    
}

extension AlarmViewController: EditButtonDelegate {
    func editButtonPressed(_ cell: AlarmCell) {
        let alert = UIAlertController(title: "[알림]", message: "아직 미구현된 기능입니다.", preferredStyle: .alert)
        let okAction = UIAlertAction(title: "확인", style: .default, handler: nil)
        
        alert.addAction(okAction)
        
        present(alert, animated: true)
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
            alarms[cell.id].isExpand = true
        } else {
            cell.setCollapse()
            alarms[cell.id].isExpand = false
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
