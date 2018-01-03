//
//  Repo.swift
//  MVVM_GitHub
//
//  Created by Bartłomiej Bocian on 02.01.2018.
//  Copyright © 2018 Bartłomiej Bocian. All rights reserved.
//

import Foundation
import ObjectMapper

struct ResponseResults: Mappable{

    var repos: [Repo]?
    
    init?(map: Map) {
        
    }
    
    mutating func mapping(map: Map) {
        repos     <- map["items"]
    }
}


struct Repo: Mappable{
    
    var id: Int?
    var name: String?
    var ownerName: String?
    var stars: Int?
    
    init?(map: Map) {
    
    }
    
    mutating func mapping(map: Map) {
        id        <- map["id"]
        name      <- map["name"]
        ownerName <- map["owner.login"]
        stars     <- map["stargazers_count"]
    }
}
