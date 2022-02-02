//
//  MemoListViewController.swift
//  RxPracticeMemo
//
//  Created by Min-Su Kim on 2022/02/02.
//

import UIKit

class MemoListViewController: UIViewController, ViewModelBindableType {

    let topTitleLabel = UILabel().then {
        $0.text = "목록"
        $0.textColor = .black
        $0.font = .systemFont(ofSize: 20, weight: .bold)
    }
    
    var viewModel: MemoListViewModel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setView()
        setConstraint()
    }
    
    func bindViewModel() {
        
    }
    
    func setView() {
        view.addSubview(topTitleLabel)
    }
    
    func setConstraint() {
        topTitleLabel.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(16)
            make.trailing.equalToSuperview().offset(-16)
            make.top.equalTo(view.layoutMarginsGuide.snp.top).offset(16)
        }
    }
}
