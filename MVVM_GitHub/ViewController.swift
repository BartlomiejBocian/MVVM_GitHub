//
//  ViewController.swift
//  MVVM_GitHub
//
//  Created by Bartłomiej Bocian on 02.01.2018.
//  Copyright © 2018 Bartłomiej Bocian. All rights reserved.
//

import UIKit
import RxCocoa
import RxSwift
import SwiftIcons

class ViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var searchBar: UISearchBar!
    
    let disposeBag = DisposeBag()
    
    var viewModel: ViewModel!
    
    private let cellIdentifier = "Cell"
    
    var latestSearch: Observable<String> {
        return searchBar
            .rx.text
            .orEmpty
            .debounce(0.5, scheduler: MainScheduler.instance)
            .distinctUntilChanged()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupRx()
    }
    
    func setupRx() {
        
        viewModel = ViewModel(searchQuery: latestSearch)
        
        viewModel.trackResults().bind(to: tableView.rx.items) { tableView, row, item in
            let cell: GitHubTableViewCell = tableView.dequeueReusableCell(withIdentifier: "repoCell", for: IndexPath(row: row, section: 0)) as! GitHubTableViewCell
            cell.repoName?.text = item.name
            cell.iconImageView.setIcon(icon: .fontAwesome(.github))
            return cell
            }
            .addDisposableTo(disposeBag)
        
        tableView
            .rx.itemSelected
            .subscribe(onNext: { indexPath in
                if self.searchBar.isFirstResponder == true {
                    self.view.endEditing(true)
                }
            })
            .addDisposableTo(self.disposeBag)
    }
    
}

