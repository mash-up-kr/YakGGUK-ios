import UIKit
import Floaty

class AlarmViewController: UIViewController {
    
    var didUpdateConstraints = false
    
    let floaty = Floaty()
    
    let noAlarmView = NoAlarmView()
    
    var alarms: [AlarmModel] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setBackgroundGradientLayer()
        
        initFloaty()
        
        view.addSubview(noAlarmView)
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
        
        view.addSubview(floaty)
    }
}

// MARK: - 알람 테이블뷰
extension AlarmViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100.0
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return alarms.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return UITableViewCell()
    }
    
}
