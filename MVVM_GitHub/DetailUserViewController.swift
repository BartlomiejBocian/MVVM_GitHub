//
//  DetailUserViewController.swift
//  MVVM_GitHub
//
//  Created by Bartłomiej Bocian on 05.01.2018.
//  Copyright © 2018 Bartłomiej Bocian. All rights reserved.
//

import UIKit
import SwiftIcons
import RxSwift
import RxCocoa
import SDWebImage

class DetailUserViewController: UIViewController {

    @IBOutlet weak var userNameLabel: UILabel!
    @IBOutlet weak var userFollowersLabel: UILabel!
    
    @IBOutlet weak var avatarImageView: UIImageView!
    @IBOutlet weak var userNameImageView: UIImageView!
    
    var detailItemQuery: String?
    
    var viewModel: DetailViewModel!
    var disposeBag = DisposeBag()
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setUpUI()
    }
    
    private func setUpUI() {
        userNameImageView.setIcon(icon: .fontAwesome(.user))
    
        viewModel.userName.asObservable().bind(to: self.userNameLabel.rx.text).addDisposableTo(self.disposeBag)
         viewModel.userFollowersCount.asObservable().bind(to: self.userFollowersLabel.rx.text).addDisposableTo(self.disposeBag)
        
    }
}
