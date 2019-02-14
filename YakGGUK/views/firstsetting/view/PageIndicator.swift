//
//  PageIndicator.swift
//  YakGGUK
//
//  Created by 김선재 on 09/02/2019.
//  Copyright © 2019 team1. All rights reserved.
//

import UIKit

class PageIndicator: UIView {
    
    @IBOutlet var view1: UIView!
    @IBOutlet var view2: UIView!
    var totalPage: Int = 0
    var nowPage: Int = 0
    
    func initiate(totalPage: Int) {
        self.totalPage = totalPage
        
        backgroundColor = UIColor(white: 238/255, alpha: 1)
        
        view1 = UIView(frame: self.bounds)
        view1.frame.size.width = self.frame.width / CGFloat(totalPage)
        view1.backgroundColor = UIColor(red: 48/255, green: 79/255, blue: 254/255, alpha: 1)
        
        view2 = UIView(frame: self.bounds)
        view2.frame.size.width = 0
        view2.backgroundColor = UIColor(red: 130/255, green: 177/255, blue: 255/255, alpha: 1)
        
        addSubview(view2)
        addSubview(view1)
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
            self.view1.frame.origin.x = self.view1.frame.width * CGFloat(self.nowPage)
            self.view2.frame.size.width = self.view1.frame.width * CGFloat(self.nowPage)
        })
    }
}
