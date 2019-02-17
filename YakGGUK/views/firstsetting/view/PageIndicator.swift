//
//  PageIndicator.swift
//  YakGGUK
//
//  Created by 김선재 on 09/02/2019.
//  Copyright © 2019 team1. All rights reserved.
//

import UIKit

class PageIndicator: UIView {
    
    var backgroundView: UIView!
    var totalPage: Int = 0
    var nowPage: Int = 0
    
    func initiate(totalPage: Int) {
        self.totalPage = totalPage
        
        backgroundView = UIView(frame: self.bounds)
        backgroundView.frame.size.width = self.frame.width / CGFloat(totalPage)
        
        backgroundView.setHorizontalGradientLayer()
        
        addSubview(backgroundView)
    }
    
    func next() {
        if (nowPage + 1 < totalPage) {
            nowPage += 1
            updateUI()
        }
    }
    
    func prev() {
        if (nowPage - 1 >= 0) {
            nowPage -= 1
            updateUI()
        }
    }
    
    private func updateUI() {
        UIView.animate(withDuration: 0.4, animations: {
            self.backgroundView.frame.size.width = self.frame.width / CGFloat(self.totalPage) * CGFloat(self.nowPage + 1)
            
            self.backgroundView.updateHorizontalGradientLayer()
        })
    }
}
