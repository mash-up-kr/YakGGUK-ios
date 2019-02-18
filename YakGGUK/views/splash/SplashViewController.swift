//
//  SplashViewController.swift
//  YakGGUK
//
//  Created by 김선재 on 18/02/2019.
//  Copyright © 2019 team1. All rights reserved.
//

import UIKit
import Lottie

class SplashViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let animationView = LOTAnimationView(name: "logo")
        
        animationView.frame = CGRect(x: 0, y: 0, width: 160, height: 228)
        animationView.center = self.view.center
        animationView.contentMode = .scaleAspectFill
        
        view.addSubview(animationView)
        
        animationView.play { (finished) in
            if finished {
                self.clockAction()
            }
        }
    }
    
    func clockAction() {
        guard let alarmListVC = UIStoryboard(name: "AlarmListNavigationController", bundle: nil).instantiateViewController(withIdentifier: "AlarmListNavigationView") as? AlarmListNavigationController else {
            return
        }
        
        self.present(alarmListVC, animated: false, completion: nil)
    }
}
