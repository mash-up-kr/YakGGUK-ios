//
//  CheckBoxButton.swift
//  YakGGUK
//
//  Created by juhee on 2018. 11. 25..
//  Copyright © 2018년 team1. All rights reserved.
//  기상, 점심, 저녁, 취침 체크할 때 쓴다.
//  알람 등록 화면에서 사용됨.

import UIKit

@IBDesignable
class CheckBoxButton: UIView {
    // Images
    let checkedImage = UIImage(named: "ic_check_box")! as UIImage
    let uncheckedImage = UIImage(named: "ic_check_box_outline_blank")! as UIImage
    
    @IBOutlet weak var checkImage: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var contentButton: UIButton!
    
    weak var buttonDelegate: CheckBoxButtonDeleagate?
    
    // Bool property
    var isChecked: Bool = false {
        didSet {
            if isChecked == true {
                self.checkImage.image = checkedImage
            } else {
                self.checkImage.image = uncheckedImage
            }
        }
    }
    var contentView: UIView?
    
    @IBInspectable var title: String = "" {
        didSet {
            self.titleLabel.text = title
            contentView?.prepareForInterfaceBuilder()
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        xibSetup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        xibSetup()
    }
    
    override func prepareForInterfaceBuilder() {
        super.prepareForInterfaceBuilder()
        xibSetup()
        self.titleLabel.text = title
        contentView?.prepareForInterfaceBuilder()
    }
    
    func xibSetup() {
        guard let view = loadViewFromNib() else {return}
        view.frame = bounds
        view.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        addSubview(view)
        contentView = view
    }
    
    func loadViewFromNib() -> UIView? {
        let bundle = Bundle(for: type(of: self))
        let nib = UINib(nibName: "CheckBoxButton", bundle: bundle)
        return nib.instantiate(
            withOwner: self,
            options: nil).first as? UIView
    }
    
    override func awakeFromNib() {
        self.contentButton.addTarget(self, action:#selector(buttonClicked(sender:)), for: UIControl.Event.touchUpInside)
        self.isChecked = false
    }
    
    @objc func buttonClicked(sender: UIButton) {
        if sender == self.contentButton {
            isChecked.toggle()
            buttonDelegate?.actionButtonClicked(isChecked, self.title)
        }
    }
}

protocol CheckBoxButtonDeleagate: class {
    func actionButtonClicked(_ checked : Bool, _ title : String)
}
