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
    
    let viewModel = DetailViewModel()
    var disposeBag = DisposeBag()
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setUpUI()
    }
    
    private func setUpUI() {
        userNameImageView.setIcon(icon: .fontAwesome(.user))
    
        if let query = detailItemQuery {
            viewModel.fetchUser(userName: query)
                .subscribe(onNext: { [weak self] user in
                    DispatchQueue.main.async{
                        self?.userNameLabel.text = user.userName
                        if let avatar = user.avatar{
                        self?.avatarImageView.sd_setImage(with: URL(string: avatar), placeholderImage: UIImage(named: "placeholder.png"))
                        }
                        if let followersCount = user.followers {
                            self?.userFollowersLabel.text = "\(followersCount)"
                        }
                    }
                    }, onError: {error in print(error)})
                .addDisposableTo(self.disposeBag)
        }
    }

}
