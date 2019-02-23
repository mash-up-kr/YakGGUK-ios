//
//  AlarmViewController.swift
//  YakGGUK
//
//  Created by 김선재 on 19/02/2019.
//  Copyright © 2019 team1. All rights reserved.
//

import UIKit

class AlarmPageViewController: UIViewController {

    // var shouldAlarmModel: AlarmModel!
    
    @IBOutlet weak var ampmLabel: UILabel!
    @IBOutlet weak var timeLabel: UILabel!
    
    @IBOutlet weak var scrollView: UIScrollView!
    
    @IBOutlet weak var stackView: UIStackView!
    
    @IBOutlet weak var pageControl: UIPageControl!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setVerticalGradientLayer()
        
    }
    
    override var prefersStatusBarHidden: Bool {
        return true
    }
}
//
//extension AlarmPageViewController: UIPageViewControllerDelegate {
//    
//}
//
//extension AlarmPageViewController: UIPageViewControllerDataSource {
//    
//}
