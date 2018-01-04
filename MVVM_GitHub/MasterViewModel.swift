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

struct MasterViewModel {
    
    let searchQuery: Observable<String>
    
    func trackResults() -> Observable<[SimpleRepo]> {
        return searchQuery
            .observeOn(MainScheduler.instance)
            .flatMapLatest{ query -> Observable<SearchResponseResults> in
                return self.fetchRepo(repo: query)
            }
            .flatMapLatest{ repo -> Observable<Optional<[SimpleRepo]>> in
                return Observable<Optional<[SimpleRepo]>>.just(repo.repos)
            }.replaceNilWith([])
    }
    
    internal func fetchRepo(repo: String) -> Observable<SearchResponseResults> {
        return URLSession.shared.rx.json(request: APIEndpoints.repositories(query: repo).request).mapObject(type: SearchResponseResults.self).catchError{ error -> Observable<SearchResponseResults> in
            return Observable<SearchResponseResults>.just(SearchResponseResults.init())
        }
    }
}
