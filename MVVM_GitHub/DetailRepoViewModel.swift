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
    
    let searchQuery: Observable<String>
    
    func fetchRepository() -> Observable<Repository> {
        return searchQuery
            .observeOn(MainScheduler.instance)
            .flatMapLatest{ query -> Observable<[SectionOfCustomData]> in
                return self.fetchSearchResult(query: query)
        }
    }
    
    internal func fetchSearchResult(query: String) -> Observable<[SectionOfCustomData]> {
        return getRepo(query: query)
    }
    
    internal func getRepo(query: String) -> Observable<[SectionOfCustomData]> {
        return URLSession.shared.rx.json(request: APIEndpoints.repositories(query: query).request)
            .mapObject(type: SearchRepoResponseResults.self)
            .flatMapLatest{ repoResponse -> Observable<[SectionOfCustomData]?> in
                if let repos = repoResponse.repos {
                    return self.getUser(query: query, reposList: repos)
                } else {
                    return Observable<[SectionOfCustomData]?>.just([])
                }
            }
            .replaceNilWith([])
            .catchError{ error ->  Observable<[SectionOfCustomData]> in
                Observable<[SectionOfCustomData]>.just([])
        }
    }
    
    internal func getUser(query: String, reposList: [SimpleRepo]) -> Observable<[SectionOfCustomData]?> {
        return URLSession.shared.rx.json(request: APIEndpoints.users(query: query).request)
            .mapObject(type: SearchUserResponseResults.self)
            .flatMapLatest{ userResponse -> Observable<[SectionOfCustomData]?> in
                if let userList = userResponse.users {
                    var transitionRepoResult: [CellModel] = []
                    var transitionUserResult: [CellModel] = []
                    for repo in reposList {
                        if let repoId = repo.id {
                            if let repoName = repo.name {
                                guard let repoCellModel = CellModel.init(id: repoId, name: repoName, cellType: .repoCell) else { break }
                                transitionRepoResult.append(repoCellModel)
                            }
                        }
                    }
                    for user in userList {
                        if let userId = user.id {
                            if let userName = user.userName {
                                guard let userCellModel = CellModel.init(id: userId, name: userName, cellType: .userCell) else { break }
                                transitionUserResult.append(userCellModel)
                            }
                        }
                    }
                    let items = Observable<[SectionOfCustomData]?>.just([
                        SectionOfCustomData(header: "Repo section", items: transitionRepoResult),
                        SectionOfCustomData(header: "User section", items: transitionUserResult)
                        ])
                    return items
                    
                } else {
                    return Observable<[SectionOfCustomData]?>.just([])
                }
            }
            .catchError{ error ->  Observable<[SectionOfCustomData]?> in
                Observable<[SectionOfCustomData]?>.just([])
        }
    }
    
}

