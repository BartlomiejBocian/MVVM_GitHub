//
//  Repo.swift
//  MVVM_GitHub
//
//  Created by Bartłomiej Bocian on 02.01.2018.
//  Copyright © 2018 Bartłomiej Bocian. All rights reserved.
//

import Foundation
import ObjectMapper

struct SearchResponseResults: Mappable{

    var repos: [SimpleRepo]?
    var users: [SimpleUser]?
    
    init?(map: Map) {
        
    }
    init() {
        
    }
    
    mutating func mapping(map: Map) {
        repos     <- map["items"]
    }
}


struct SimpleRepo: Mappable{
    
    var id: Int?
    var name: String?
    var ownerName: String?
    
    init?(map: Map) {
    
    }
    
    mutating func mapping(map: Map) {
        id        <- map["id"]
        name      <- map["name"]
        ownerName <- map["owner.login"]
    }
}

struct SimpleUser: Mappable{
    
    var id: Int?
    var userName: String?
    
    init?(map: Map) {
        
    }
    
    mutating func mapping(map: Map) {
        id        <- map["id"]
        userName  <- map["login"]
    }
}
