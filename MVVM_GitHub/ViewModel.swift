//
//  ViewModel.swift
//  MVVM_GitHub
//
//  Created by Bartłomiej Bocian on 02.01.2018.
//  Copyright © 2018 Bartłomiej Bocian. All rights reserved.
//

import Foundation
import RxOptional
import RxSwift
import RxObjectMapper

struct ViewModel {
    
    let searchQuery: Observable<String>
    
    func trackResults() -> Observable<ResponseResults> {
        return searchQuery
            .observeOn(MainScheduler.instance)
            .flatMapLatest({ query -> Observable<ResponseResults> in
                return self.fetchRepo(repo: query)
            })
    }
    
    internal func fetchRepo(repo: String) -> Observable<ResponseResults> {
        return URLSession.shared.rx.json(request: APIEndpoints.repositories(query: repo).request).mapObject(type: ResponseResults.self)
    }
}
