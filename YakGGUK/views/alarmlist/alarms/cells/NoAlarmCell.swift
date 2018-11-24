import UIKit

protocol AddAlarmButtonDelegate: class {
    func buttonPressed(_ cell: NoAlarmCell)
}

class NoAlarmCell: UITableViewCell {

    @IBOutlet weak var noalarmImage: UIImageView!
    
    @IBOutlet weak var titleLabel: UILabel!
    
    weak var delegate: AddAlarmButtonDelegate?
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    func setDelegate(_ delegate: AddAlarmButtonDelegate) {
        self.delegate = delegate
    }
    
    @IBAction func buttonPressed(_ sender: Any) {
        delegate?.buttonPressed(self)
    }
}
