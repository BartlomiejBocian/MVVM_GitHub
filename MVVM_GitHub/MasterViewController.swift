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

class MasterViewController: UIViewController, UITableViewDelegate {
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var searchBar: UISearchBar!
    
    private let disposeBag = DisposeBag()
    
    private var viewModel: MasterViewModel!
    
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
    
    // MARK: - RX
    
    private func setupRx() {
        viewModel = MasterViewModel(searchQuery: latestSearch)
        bindSourceData()
        selectTableViewCell()
    }
    
    private func bindSourceData() {
        viewModel
            .trackResults()
            .bind(to: tableView.rx.items) { tableView, row, item in
                let cell: GitHubTableViewCell = tableView.dequeueReusableCell(withIdentifier: "repoCell", for: IndexPath(row: row, section: 0)) as! GitHubTableViewCell
                cell.repoName?.text = item.name
                cell.iconImageView.setIcon(icon: .fontAwesome(.github))
                return cell
            }
            .addDisposableTo(disposeBag)
    }
    
    private func selectTableViewCell() {
        tableView
            .rx.modelSelected(SimpleRepo.self)
            .subscribe(onNext:  { value in
                if self.searchBar.isFirstResponder == true {
                    self.view.endEditing(true)
                }
                guard let detailVC = self.storyboard?.instantiateViewController(withIdentifier: "DetailViewController") as? DetailViewController
                    else { fatalError("DetailViewController not found") }
//                detailVC.detailItem = value
                self.navigationController?.pushViewController(detailVC, animated: true)
            }, onError:{error in
                print(error)
            })
            .addDisposableTo(self.disposeBag)
    }
}
