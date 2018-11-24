import UIKit

protocol PresentAlertDelegate: class {
    func showAlertController(_ alert: UIAlertController)
}

class AlarmDetailCell: UITableViewCell {
    
    @IBOutlet weak var medicineTableView: UITableView!
    
    var medicines: [MedicineModel] = []
    
    weak var delegate: PresentAlertDelegate?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        medicineTableView.separatorStyle = .none
        medicineTableView.allowsSelection = false
        
        medicineTableView.delegate = self
        medicineTableView.dataSource = self
    }
    
    func setDelegate(_ delegate: PresentAlertDelegate) {
        self.delegate = delegate
    }

    func setMedicines(_ medicines: [MedicineModel]) {
        self.medicines = medicines
        medicineTableView.reloadData()
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

}

extension AlarmDetailCell: DetailButtonDelegate {
    func buttonPressed(_ cell: MedicineCell) {
        let alert = UIAlertController(title: "[알림]", message: "아직 미구현된 기능입니다.", preferredStyle: .alert)
        
        let okAction = UIAlertAction(title: "확인", style: .default, handler: nil)
        
        alert.addAction(okAction)
        delegate?.showAlertController(alert)
    }
}

extension AlarmDetailCell: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80.0
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return medicines.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = medicineTableView.dequeueReusableCell(withIdentifier: "medicine", for: indexPath) as? MedicineCell else {
            return UITableViewCell()
        }
        
        let medicine = medicines[indexPath.row]
        
        cell.setName(medicine.name)
        cell.setDescription(medicine.description)
        cell.delegate = self
        
        return cell
    }
    
}
