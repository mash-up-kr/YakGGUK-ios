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
    }

    @IBAction func searchMedicine(_ sender: UIButton) {
        guard let nextVC = UIStoryboard(name: "Search", bundle: nil).instantiateViewController(withIdentifier: "barcode_scan") as? BarcodeScanViewController else {
            return
        }
        self.present(UINavigationController(rootViewController: nextVC), animated: false, completion: nil)
    }
    
}
