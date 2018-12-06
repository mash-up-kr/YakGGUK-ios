//
//  ViewController.swift
//  Secret
//
//  Created by 김선재 on 24/11/2018.
//  Copyright © 2018 team1. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        let gradient = CAGradientLayer()
        gradient.frame = view.bounds
        gradient.colors = [UIColor(named: "gradientLeading")!.cgColor, UIColor(named: "gradientTrailing")!.cgColor]
        gradient.startPoint = CGPoint(x: 0, y: 0.5)
        gradient.endPoint = CGPoint(x: 1, y: 0.5)
        view.layer.insertSublayer(gradient, at: 0)
    }

    @IBAction func searchMedicine(_ sender: UIButton) {
        guard let nextVC = UIStoryboard(name: "Search", bundle: nil).instantiateViewController(withIdentifier: "barcode_scan") as? BarcodeScanViewController else {
            return
        }
        self.present(UINavigationController(rootViewController: nextVC), animated: false, completion: nil)
    }
    
}
