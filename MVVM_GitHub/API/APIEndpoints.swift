//
//  APIEndpoints.swift
//  MVVM_GitHub
//
//  Created by Bartłomiej Bocian on 02.01.2018.
//  Copyright © 2018 Bartłomiej Bocian. All rights reserved.
//

import Foundation

enum APIEndpoints {
    case repositories(query: String)
    case users(query: String)
    case repository(query: String)
    case user(query: String)
}

extension APIEndpoints {
    
    var basePath: String {
        return "https://api.github.com/"
    }
    
    var baseParams: String {
        return "&sort=id&order=asc"
    }
    
    var path: URL {
        switch self {
        case .repositories(let query):
            return URL(string: basePath + "search/" + "repositories?q=" + query + baseParams)!
        case .users(let query):
            return URL(string: basePath + "search/" + "users?q=" + query + baseParams)!
        case .repository(let query):
            return URL(string: basePath + "repos/" + query)!
        case .user(let query):
            return URL(string: basePath + "users/" + query)!
        }
    }
    
    var request: URLRequest {
        return URLRequest(url: self.path)
    }
    
}
