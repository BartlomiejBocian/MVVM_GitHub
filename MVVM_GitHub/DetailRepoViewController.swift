//
//  DetailViewController.swift
//  MVVM_GitHub
//
//  Created by Bartłomiej Bocian on 04.01.2018.
//  Copyright © 2018 Bartłomiej Bocian. All rights reserved.
//

import UIKit
import SwiftIcons
import RxSwift
import RxCocoa

class DetailRepoViewController: UIViewController {
    
    @IBOutlet weak var repositoryNameLabel: UILabel!
    @IBOutlet weak var repositoryOwnerLabel: UILabel!
    @IBOutlet weak var repositoryStarsLabel: UILabel!
    
    @IBOutlet weak var repositoryNameImageView: UIImageView!
    @IBOutlet weak var repositoryOwnerImageView: UIImageView!
    @IBOutlet weak var repositoryStarsImageView: UIImageView!
    
    var detailItemQuery: String?
    
    let viewModel = DetailViewModel()
    var disposeBag = DisposeBag()
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setUpUI()
    }
    
    private func setUpUI() {
        repositoryNameImageView.setIcon(icon: .fontAwesome(.github))
        repositoryOwnerImageView.setIcon(icon: .fontAwesome(.user))
        repositoryStarsImageView.setIcon(icon: .fontAwesome(.star))
        
        if let query = detailItemQuery {
            viewModel.fetchRepository(fullName: query)
                .subscribe(onNext: { [weak self] repo in
                    DispatchQueue.main.async{
                        self?.repositoryNameLabel.text = repo.name
                        self?.repositoryOwnerLabel.text = repo.ownerName
                        if let starCount = repo.stars {
                            self?.repositoryStarsLabel.text = "\(starCount)"
                        }
                    }
                }, onError: {error in print(error)})
                .addDisposableTo(self.disposeBag)
        }
    }
    
}
