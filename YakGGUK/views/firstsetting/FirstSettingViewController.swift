//
//  FirstSettingViewController.swift
//  YakGGUK
//
//  Created by 김선재 on 25/01/2019.
//  Copyright © 2019 team1. All rights reserved.
//

import UIKit

class FirstSettingViewController: UIViewController {

    private var didUpdateConstraints = false
    
    private let settingView = SettingView()
    
    private let settingViews = [WakeUpSettingView(),
                                LunchSettingView(),
                                DinnerSettingView(),
                                SleepSettingView()]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        for view in settingViews {
            settingView.append(settingView: view)
        }
        
        view.addSubview(settingView)
        
        view.updateConstraintsIfNeeded()
        
        settingView.reloadSettingViewContainer()
    }
    
    override func viewDidLayoutSubviews() {
        settingView.setBackgroundGradient()
    }
    
    override func updateViewConstraints() {
        if !didUpdateConstraints {
            
            NSLayoutConstraint.activate([
                settingView.topAnchor.constraint(equalTo: view.topAnchor),
                settingView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
                settingView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
                settingView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
            ])
            
            didUpdateConstraints.toggle()
        }
        
        super.updateViewConstraints()
    }
}
