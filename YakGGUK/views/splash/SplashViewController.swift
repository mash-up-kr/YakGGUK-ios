//
//  SplashViewController.swift
//  YakGGUK
//
//  Created by 김선재 on 18/02/2019.
//  Copyright © 2019 team1. All rights reserved.
//

import UIKit

class SplashViewController: UIViewController {
    
    var didUpdateConstraints = false
    
    let splashView = SplashView()
    
    var timer: Timer!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.addSubview(splashView)
        view.updateConstraintsIfNeeded()
        
        timer = Timer.scheduledTimer(timeInterval: 1.5, target: self, selector: #selector(clockAction), userInfo: nil, repeats: false)
    }
    
    @objc
    func clockAction() {
        guard let alarmListVC = UIStoryboard(name: "AlarmListNavigationController", bundle: nil).instantiateViewController(withIdentifier: "AlarmListNavigationView") as? AlarmListNavigationController else {
            return
        }
        
        self.present(alarmListVC, animated: false, completion: nil)
        
        timer.invalidate()
    }
    
    override func updateViewConstraints() {
        if !didUpdateConstraints {
            
            NSLayoutConstraint.activate([
                splashView.topAnchor.constraint(equalTo: view.topAnchor),
                splashView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
                splashView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
                splashView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
            ])
            
            didUpdateConstraints.toggle()
        }
        
        super.updateViewConstraints()
    }
    
}
