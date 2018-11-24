import UIKit

protocol AlarmButtonDelegate: class {
    func buttonPressed(_ cell: AlarmCell)
}

class AlarmCell: UITableViewCell {
    
    @IBOutlet weak var innerView: UIView!
    @IBOutlet weak var whenLabel: UILabel!
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var collapseButton: UIButton!
    
    var isExpand: Bool = false
    
    weak var delegate: AlarmButtonDelegate?
    
    override func awakeFromNib() {
        innerView.layer.borderWidth = 1.0
        innerView.layer.borderColor = UIColor.black.cgColor
        innerView.layer.cornerRadius = innerView.frame.height / 2
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    func setWhen(_ when: enumWhen) {
        whenLabel.text? = when.description()
    }

    func setTime(_ time: String) {
        timeLabel.text? = time
    }

    func setExpand() {
        collapseButton.setTitle("접기", for: .normal)
        isExpand = true
    }

    func setCollapse() {
        collapseButton.setTitle("펼치기", for: .normal)
        isExpand = false
    }

    func setDelegate(_ delegate: AlarmButtonDelegate) {
        self.delegate = delegate
    }

    @IBAction func collapseAction(_ sender: Any) {
        delegate?.buttonPressed(self)
    }

}
