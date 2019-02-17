//
//  SplashView.swift
//  YakGGUK
//
//  Created by 김선재 on 18/02/2019.
//  Copyright © 2019 team1. All rights reserved.
//

import UIKit

class SplashView: UIView {

    private var didUpdateConstraints = false
    
    private var symbolImage: UIImageView = {
        let image = UIImageView()
        image.image = #imageLiteral(resourceName: "symbol")
        
        image.translatesAutoresizingMaskIntoConstraints = false
        
        return image
    }()
    
    private var logoImage: UIImageView = {
        let image = UIImageView()
        image.image = #imageLiteral(resourceName: "logo")
        
        image.translatesAutoresizingMaskIntoConstraints = false
        
        return image
    }()
    
    private var containerView: UIView = {
        let view = UIView()
        
        view.translatesAutoresizingMaskIntoConstraints = false
        
        return view
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.translatesAutoresizingMaskIntoConstraints = false
        
        containerView.addSubview(symbolImage)
        containerView.addSubview(logoImage)
        
        addSubview(containerView)
        
        setNeedsUpdateConstraints()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder: ) not been implemented")
    }
    
    override func updateConstraints() {
        if !didUpdateConstraints {
            
            NSLayoutConstraint.activate([
                containerView.widthAnchor.constraint(equalToConstant: 160.0),
                containerView.heightAnchor.constraint(equalToConstant: 228.0),
                containerView.centerXAnchor.constraint(equalTo: self.centerXAnchor),
                containerView.centerYAnchor.constraint(equalTo: self.centerYAnchor)
            ])
            
            NSLayoutConstraint.activate([
                symbolImage.widthAnchor.constraint(equalToConstant: 160.0),
                symbolImage.heightAnchor.constraint(equalToConstant: 134.0),
                symbolImage.topAnchor.constraint(equalTo: containerView.topAnchor),
                symbolImage.centerXAnchor.constraint(equalTo: containerView.centerXAnchor)
            ])
            
            NSLayoutConstraint.activate([
                logoImage.widthAnchor.constraint(equalToConstant: 152.0),
                logoImage.heightAnchor.constraint(equalToConstant: 86.0),
                logoImage.topAnchor.constraint(equalTo: symbolImage.bottomAnchor, constant: 8.0),
                logoImage.centerXAnchor.constraint(equalTo: containerView.centerXAnchor)
            ])
            
            didUpdateConstraints.toggle()
        }
        
        super.updateConstraints()
    }
    
}
