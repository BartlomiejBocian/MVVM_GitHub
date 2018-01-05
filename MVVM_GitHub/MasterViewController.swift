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
import RxDataSources

struct SectionOfCustomData {
    var header: String
    var items: [CellModel]
}
extension SectionOfCustomData: SectionModelType {
    
    init(original: SectionOfCustomData, items: [CellModel]) {
        self = original
        self.items = items
    }
}

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
        let dataSource = RxTableViewSectionedReloadDataSource<SectionOfCustomData>()
        dataSource.configureCell = { (_, tv, indexPath, element) in
            let cell = tv.dequeueReusableCell(withIdentifier: "repoCell")! as! GitHubTableViewCell
            cell.repoName.text = element.name
            switch element.type {
            case .repoCell?:
                cell.iconImageView.setIcon(icon: .fontAwesome(.github))
                break
            case .userCell?:
                cell.iconImageView.setIcon(icon: .fontAwesome(.user))
                break
            case .none:
                break
            }
            return cell
        }
        dataSource.titleForHeaderInSection = { ds, index in
            return ds.sectionModels[index].header
        }
        viewModel
            .trackResults()
            .bind(to: tableView.rx.items(dataSource: dataSource))
            .addDisposableTo(disposeBag)
    }
    
    private func selectTableViewCell() {
        tableView
            .rx.modelSelected(CellModel.self)
            .subscribe(onNext:  { value in
                if self.searchBar.isFirstResponder == true {
                    self.view.endEditing(true)
                }
                switch value.type {
                case .repoCell?:
                    guard let detailVC = self.storyboard?.instantiateViewController(withIdentifier: "DetailRepoViewController") as? DetailRepoViewController
                        else { fatalError("DetailViewController not found") }
                    detailVC.detailItemQuery = value.name
                    self.navigationController?.pushViewController(detailVC, animated: true)
                    break
                case .userCell?:
                    guard let detailVC = self.storyboard?.instantiateViewController(withIdentifier: "DetailUserViewController") as? DetailUserViewController
                        else { fatalError("DetailViewController not found") }
                    detailVC.detailItemQuery = value.name
                    self.navigationController?.pushViewController(detailVC, animated: true)
                    break
                case .none:
                    break
                }
                
            }, onError:{error in
                print(error)
            })
            .addDisposableTo(self.disposeBag)
    }
}
