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
    
    var disposeBag = DisposeBag()
    
    var viewModel: DetailViewModel!
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setUpUI()
    }
    
    private func setUpUI() {
        
        repositoryNameImageView.setIcon(icon: .fontAwesome(.github))
        repositoryOwnerImageView.setIcon(icon: .fontAwesome(.user))
        repositoryStarsImageView.setIcon(icon: .fontAwesome(.star))
        
        if let query = detailItemQuery {
            
            viewModel.repoName.asObservable().bind(to: self.repositoryNameLabel.rx.text).addDisposableTo(self.disposeBag)
            viewModel.repoOwner.asObservable().bind(to: self.repositoryOwnerLabel.rx.text).addDisposableTo(self.disposeBag)
            viewModel.repoStar.asObservable().bind(to: self.repositoryStarsLabel.rx.text).addDisposableTo(self.disposeBag)
        }
    }
    
}
