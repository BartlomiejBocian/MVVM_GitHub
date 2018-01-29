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

class DetailViewModel {
    
    var repoName: Variable<String?>
    var repoOwner: Variable<String?>
    var repoStar: Variable<String?>
    
    var userFollowersCount: Variable<String?>
    var userName: Variable<String?>
    
    var disposeBag = DisposeBag()
    
    init (query: String) {
        repoName = Variable<String?>.init("")
        repoOwner = Variable<String?>.init("")
        repoStar = Variable<String?>.init("")
        userFollowersCount = Variable<String?>.init("")
        userName = Variable<String?>.init("")
        self.fetchRepository(fullName: query)
    }
    
    init (queryUserName: String) {
        repoName = Variable<String?>.init("")
        repoOwner = Variable<String?>.init("")
        repoStar = Variable<String?>.init("")
        userFollowersCount = Variable<String?>.init("")
        userName = Variable<String?>.init("")
        self.fetchUser(userName: queryUserName)
    }
    
    func fetchRepository(fullName: String) {
        URLSession.shared.rx.json(request: APIEndpoints.repository(query: fullName).request).mapObject(type: Repository.self).subscribe(onNext: { [weak self] repo in
            self?.repoName.value = repo.name
            self?.repoOwner.value = repo.ownerName
            if let starCount = repo.stars {
                self?.repoStar.value = "\(starCount)"
            }
            }, onError: {error in print(error)})
            .addDisposableTo(self.disposeBag)
    }
    
    func fetchUser(userName: String) {
        return URLSession.shared.rx.json(request: APIEndpoints.user(query: userName).request).mapObject(type: User.self).subscribe(onNext: { [weak self] user in
            self?.userName.value = user.userName
            self?.userFollowersCount.value = "\(user.followers)"
            }, onError: {error in print(error)})
            .addDisposableTo(self.disposeBag)
    }
}

