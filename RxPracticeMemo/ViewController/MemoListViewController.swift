//
//  MemoListViewController.swift
//  RxPracticeMemo
//
//  Created by Min-Su Kim on 2022/02/02.
//

import UIKit
import RxSwift
import RxCocoa
import NSObject_Rx

class MemoListViewController: UIViewController, ViewModelBindableType {

    let topTitleLabel = UILabel().then {
        $0.text = "목록"
        $0.textColor = .black
        $0.font = .systemFont(ofSize: 16, weight: .bold)
    }
    
    let addButton = UIButton().then {
        $0.setImage(UIImage(systemName: "plus"), for: .normal)
        $0.tintColor = .darkText
        $0.contentMode = .scaleToFill
    }
    
    let tableView = UITableView().then {
        $0.register(MemoListTableViewCell.self, forCellReuseIdentifier: "MemoListTableViewCell")
    }
    
    var viewModel: MemoListViewModel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setView()
        setConstraint()
    }
    
    func bindViewModel() {
        viewModel.title
            .drive(topTitleLabel.rx.text)
            .disposed(by: rx.disposeBag)
        
        viewModel.memoList
            .bind(to: tableView.rx.items(cellIdentifier: "MemoListTableViewCell", cellType: MemoListTableViewCell.self)) { row, memo, cell in
                cell.contentLabel.text = memo.content
            }
            .disposed(by: rx.disposeBag)
    }
    
    func setView() {
        view.backgroundColor = .white
        view.addSubview(topTitleLabel)
        view.addSubview(addButton)
        view.addSubview(tableView)
    }
    
    func setConstraint() {
        topTitleLabel.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(16)
            make.trailing.equalToSuperview().offset(-16)
            make.top.equalTo(view.layoutMarginsGuide.snp.top).offset(16)
        }
        
        addButton.snp.makeConstraints { make in
            make.trailing.equalToSuperview().offset(-16)
            make.centerY.equalTo(self.topTitleLabel.snp.centerY)
        }
        
        tableView.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview()
            make.top.equalTo(self.topTitleLabel.snp.bottom).offset(16)
            make.bottom.equalToSuperview()
        }
    }
}
