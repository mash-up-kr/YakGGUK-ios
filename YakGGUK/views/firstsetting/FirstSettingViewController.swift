//
//  FirstSettingViewController.swift
//  YakGGUK
//
//  Created by 김선재 on 25/01/2019.
//  Copyright © 2019 team1. All rights reserved.
//

import UIKit

protocol INextable: class {
    func nextable()
}

class FirstSettingViewController: UIViewController {
    
    @IBOutlet weak var pageIndicator: PageIndicator!
    @IBOutlet weak var scrollView: UIScrollView!
    
    @IBOutlet weak var backButton: UIButton!
    @IBOutlet weak var nextButton: UIButton!
    
    var alarmVC: AlarmViewController!
    
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
        
        backButton.isHidden = true
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
            
            if currentIndex == 1 {
                backButton.isHidden = false
            }
            
            if currentIndex + 1 == total {
                nextButton.setTitle("완료", for: .normal)
            }
        } else {
            sleepIVC.nextable()
            
            let alert = UIAlertController(title: "첫 등록을 마치겠습니까?", message: "후에 알람 수정이 가능합니다.", preferredStyle: .alert)
            
            alert.addAction(UIAlertAction(title: "예", style: .default, handler: { _ in
                self.complete()
            }))
                
            alert.addAction(UIAlertAction(title: "아니요", style: .cancel, handler: nil))
            
            present(alert, animated: true)
        }
    }
    
    private func complete() {
        guard let ATWakeUp = wakeUpIVC.mAlarmTime else { return }
        guard let ATLunch = lunchIVC.mAlarmTime else { return }
        guard let ATDinner = dinnerIVC.mAlarmTime else { return }
        guard let ATSleep = sleepIVC.mAlarmTime else { return }
        
        let bSuccess = LocalDataCenter.saveAlarmTimes(alarmTimes: [ATWakeUp, ATLunch, ATDinner, ATSleep])
        
        dismiss(animated: true) {
            if bSuccess {
                self.alarmVC.loadAlarmModel()
            } else {
                let alert = UIAlertController(title: "알 수 없는 오류로 알람 등록을 실패했습니다.", message: "후에 알람 수정이 가능합니다.", preferredStyle: .alert)
                
                alert.addAction(UIAlertAction(title: "확인", style: .default, handler: nil))
                
                self.present(alert, animated: true)
            }
        }
    }
        
    private func updateUI(currentIndex: Int) {
        let tmp = CGPoint(x: CGFloat(currentIndex) * scrollView.frame.width, y: 0.0)
        scrollView.setContentOffset(tmp, animated: true)
        
        switch currentIndex {
        case 1:
            wakeUpIVC.nextable()
        case 2:
            lunchIVC.nextable()
        case 3:
            dinnerIVC.nextable()
        default:
            return
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
