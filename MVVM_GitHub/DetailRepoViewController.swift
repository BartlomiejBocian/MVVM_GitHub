//
//  DetailViewController.swift
//  MVVM_GitHub
//
//  Created by Bartłomiej Bocian on 04.01.2018.
//  Copyright © 2018 Bartłomiej Bocian. All rights reserved.
//

import UIKit
import SwiftIcons

class DetailRepoViewController: UIViewController {
    
    @IBOutlet weak var repositoryNameLabel: UILabel!
    @IBOutlet weak var repositoryOwnerLabel: UILabel!
    @IBOutlet weak var repositoryStarsLabel: UILabel!
    
    @IBOutlet weak var repositoryNameImageView: UIImageView!
    @IBOutlet weak var repositoryOwnerImageView: UIImageView!
    @IBOutlet weak var repositoryStarsImageView: UIImageView!
    
    var detailItemQuery: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setUpUI()
    }
    
    private func setUpUI() {
        repositoryNameImageView.setIcon(icon: .fontAwesome(.github))
        repositoryOwnerImageView.setIcon(icon: .fontAwesome(.user))
        repositoryStarsImageView.setIcon(icon: .fontAwesome(.star))
        if let model = detailItemQuery {
//            repositoryNameLabel.text = model.name
//            repositoryOwnerLabel.text = model.ownerName
        }
    }
    
}
