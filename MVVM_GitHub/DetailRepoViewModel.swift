//
//  DetailViewModel.swift
//  MVVM_GitHub
//
//  Created by Bartłomiej Bocian on 05.01.2018.
//  Copyright © 2018 Bartłomiej Bocian. All rights reserved.
//

import Foundation
import RxOptional
import RxSwift
import RxObjectMapper
import RxDataSources

struct DetailViewModel {
    
    func fetchRepository(fullName: String) -> Observable<Repository> {
        return URLSession.shared.rx.json(request: APIEndpoints.repository(query: fullName).request).mapObject(type: Repository.self).catchError{ error ->  Observable<Repository> in
            Observable<Repository>.just(Repository.init())
        }
    }
    
    func fetchUser(userName: String) -> Observable<User> {
        return URLSession.shared.rx.json(request: APIEndpoints.user(query: userName).request).mapObject(type: User.self).catchError{ error ->  Observable<User> in
            Observable<User>.just(User.init())
        }
    }
}

