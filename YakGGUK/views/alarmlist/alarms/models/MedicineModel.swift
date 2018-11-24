//
//  MedicineModel.swift
//  YakGGUK
//
//  Created by 김선재 on 24/11/2018.
//  Copyright © 2018 team1. All rights reserved.
//

import Foundation

class MedicineModel {
    // EMPTY
    var imageSource: String = ""
    var medicineId: Int = 0
    
    var name: String
    var description: String
    
    init(name: String, description: String) {
        self.name = name
        self.description = description
    }
    
    init(imageSource: String, medicineId: Int, name: String, description: String) {
        self.imageSource = imageSource
        self.medicineId = medicineId
        self.name = name
        self.description = description
    }
}
