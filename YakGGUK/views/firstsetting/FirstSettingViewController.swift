//
//  FirstSettingViewController.swift
//  YakGGUK
//
//  Created by 김선재 on 25/01/2019.
//  Copyright © 2019 team1. All rights reserved.
//

import UIKit

class FirstSettingViewController: UIViewController {
    
    @IBOutlet weak var pageIndicator: PageIndicator!
    @IBOutlet weak var scrollView: UIScrollView!
    
    @IBOutlet weak var backButton: UIButton!
    @IBOutlet weak var nextButton: UIButton!
    
    var wakeUpIVC: FirstSettingWakeUpIVC!
    var lunchIVC: FirstSettingLunchIVC!
    var dinnerIVC: FirstSettingDinnerIVC!
    var sleepIVC: FirstSettingSleepIVC!
    
    var total: Int = 0
    var currentIndex: Int = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        total = scrollView.subviews[0].subviews.count
        
        self.view.setNeedsLayout()
        self.view.layoutIfNeeded()
        
        pageIndicator.initiate(totalPage: total)
        
        nextButton.setHorizontalGradientLayer()
        
        updateUI(currentIndex: 0)
    }
    
    @IBAction func prevButton(_ sender: Any) {
        if currentIndex - 1 >= 0 {
            currentIndex -= 1
            pageIndicator.prev()
            updateUI(currentIndex: currentIndex)
        }
        
        if currentIndex == 0 {
            backButton.isHidden = true
        }
        
        if currentIndex + 2 == total {
            nextButton.setTitle("설정", for: .normal)
        }
    }
    
    @IBAction func nextButton(_ sender: Any) {
        if currentIndex + 1 < total {
            currentIndex += 1
            pageIndicator.next()
            updateUI(currentIndex: currentIndex)
        }
        
        if currentIndex == 1 {
            backButton.isHidden = false
        }
        
        if currentIndex + 1 == total {
            nextButton.setTitle("완료", for: .normal)
        }
    }
        
    private func updateUI(currentIndex: Int) {
        let tmp = CGPoint(x: CGFloat(currentIndex) * scrollView.frame.width, y: 0.0)
        scrollView.setContentOffset(tmp, animated: true)
        
        if (currentIndex == 0) {
            backButton.isHidden = true
        } else {
            backButton.isHidden = false
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let destVC = segue.destination
        
        switch destVC {
        case is FirstSettingWakeUpIVC:
            wakeUpIVC = destVC as? FirstSettingWakeUpIVC
        case is FirstSettingLunchIVC:
            lunchIVC = destVC as? FirstSettingLunchIVC
        case is FirstSettingDinnerIVC:
            dinnerIVC = destVC as? FirstSettingDinnerIVC
        case is FirstSettingSleepIVC:
            sleepIVC = destVC as? FirstSettingSleepIVC
        default:
            return
        }
    }
}
