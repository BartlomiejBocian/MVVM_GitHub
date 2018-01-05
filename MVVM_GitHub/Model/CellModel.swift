//
//  CellModel.swift
//  MVVM_GitHub
//
//  Created by Bartłomiej Bocian on 05.01.2018.
//  Copyright © 2018 Bartłomiej Bocian. All rights reserved.
//

import Foundation

enum CellType {
    case repoCell
    case userCell
}

struct CellModel{
    
    var id: Int?
    var name: String?
    var type: CellType?
    
    init?(id: Int, name: String, cellType: CellType) {
        self.id = id
        self.name = name
        self.type = cellType
    }
}
