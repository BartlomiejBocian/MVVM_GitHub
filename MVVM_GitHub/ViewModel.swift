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
    
    func trackResults() -> Observable<[Repo]> {
        return searchQuery
            .observeOn(MainScheduler.instance)
            .flatMapLatest{ query -> Observable<ResponseResults> in
                return self.fetchRepo(repo: query)
            }
            .flatMapLatest{ repo -> Observable<Optional<[Repo]>> in
                return Observable<Optional<[Repo]>>.just(repo.repos)
            }.replaceNilWith([])
    }
    
    internal func fetchRepo(repo: String) -> Observable<ResponseResults> {
        if repo.isEmpty {
            return Observable<ResponseResults>.just(ResponseResults.init())
        }
        return URLSession.shared.rx.json(request: APIEndpoints.repositories(query: repo).request).mapObject(type: ResponseResults.self)
    }
}
