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
    var stars: Int?
    
    init?(map: Map) {}
    init() {}
    
    mutating func mapping(map: Map) {
        id        <- map["id"]
        name      <- map["name"]
        ownerName <- map["owner.login"]
        stars      <- map["stargazers_count"]
    }
}

struct User: Mappable{
    
    var id: Int?
    var userName: String?
    var avatar: String?
    var followers: Int?
    
    init?(map: Map) {}
    init() {}
    
    mutating func mapping(map: Map) {
        id        <- map["id"]
        userName  <- map["name"]
        avatar    <- map["avatar_url"]
        followers <- map["followers"]
    }
}
