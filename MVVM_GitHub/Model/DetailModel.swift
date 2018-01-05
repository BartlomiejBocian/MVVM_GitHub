//
//  DetailModel.swift
//  MVVM_GitHub
//
//  Created by Bartłomiej Bocian on 05.01.2018.
//  Copyright © 2018 Bartłomiej Bocian. All rights reserved.
//

import Foundation
import ObjectMapper

struct Repository: Mappable{
    
    var id: Int?
    var name: String?
    var ownerName: String?
    
    init?(map: Map) {}
    init() {}
    
    mutating func mapping(map: Map) {
        id        <- map["id"]
        name      <- map["full_name"]
        ownerName <- map["owner.login"]
    }
}

struct User: Mappable{
    
    var id: Int?
    var userName: String?
    
    init?(map: Map) {
        
    }
    
    mutating func mapping(map: Map) {
        id        <- map["id"]
        userName  <- map["login"]
    }
}
