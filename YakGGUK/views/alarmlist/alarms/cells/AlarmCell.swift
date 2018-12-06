import UIKit

protocol AlarmButtonDelegate: class {
    func buttonPressed(_ cell: AlarmCell)
}

protocol EditButtonDelegate: class {
    func editButtonPressed(_ cell: AlarmCell)
}

class AlarmCell: UITableViewCell {
    
    @IBOutlet weak var innerView: UIView!
    @IBOutlet weak var ampmLabel: UILabel!
    @IBOutlet weak var whenLabel: UILabel!
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var collapseButton: UIButton!
    
    var id: Int = 0
    var isExpand: Bool = false
    
    weak var delegate: AlarmButtonDelegate?
    weak var editDelegate: EditButtonDelegate?
    
    override func awakeFromNib() {
        innerView.layer.cornerRadius = 6.0
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    func setId(_ id: Int) {
        self.id = id
    }
    
    func setWhen(_ when: EnumWhen) {
        whenLabel.text? = when.description()
    }

    func setTime(_ time: String) {
        timeLabel.text? = time
        
        let inFormatter = DateFormatter()
        inFormatter.locale = Locale(identifier: "en_US_POSIX")
        inFormatter.dateFormat = "HH:mm"
        
        let outFormatter = DateFormatter()
        outFormatter.locale = Locale(identifier: "en_US_POSIX")
        outFormatter.dateFormat = "a"
        
        let date = inFormatter.date(from: time)!
        let outStr = outFormatter.string(from: date)
        
        switch outStr {
        case "AM":
            ampmLabel.text = "오전"
        case "PM":
            ampmLabel.text = "오후"
        default:
            ampmLabel.text = ""
        }
    }

    func setExpand() {
        collapseButton.setImage(UIImage(named: "icUp"), for: .normal)
        isExpand = true
    }

    func setCollapse() {
        collapseButton.setImage(UIImage(named: "icDown"), for: .normal)
        isExpand = false
    }

    func setDelegate(_ delegate: AlarmButtonDelegate) {
        self.delegate = delegate
    }
    
    func setEditDelegate(_ delegate: EditButtonDelegate) {
        self.editDelegate = delegate
    }

    @IBAction func collapseAction(_ sender: Any) {
        delegate?.buttonPressed(self)
    }
    
    @IBAction func editAction(_ sender: Any) {
        editDelegate?.editButtonPressed(self)
    }
    
}
