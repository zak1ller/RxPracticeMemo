//
//  MemoDetailViewController.swift
//  RxPracticeMemo
//
//  Created by Min-Su Kim on 2022/02/02.
//

import UIKit
import RxSwift

class MemoDetailViewController: UIViewController, ViewModelBindableType {

    lazy var topTitleLabel = UILabel().then {
        $0.textColor = .darkText
        $0.font = .systemFont(ofSize: 16, weight: .bold)
    }
    
    lazy var backButton = UIButton().then {
        $0.setTitle("돌아가기", for: .normal)
        $0.setTitleColor(.darkText, for: .normal)
        $0.titleLabel?.font = .systemFont(ofSize: 14, weight: .bold)
    }
    
    lazy var contentLabel = UILabel().then {
        $0.textColor = .darkText
        $0.font = .systemFont(ofSize: 14, weight: .medium)
        $0.numberOfLines = 0
    }
    
    lazy var dateLabel = UILabel().then {
        $0.textColor = .lightGray
        $0.font = .systemFont(ofSize: 12, weight: .medium)
    }
    
    lazy var bottomButtonStackView = UIStackView().then {
        $0.axis = .horizontal
        $0.distribution = .fill
        $0.spacing = 16
    }
    
    lazy var deleteButton = UIButton().then {
        $0.setImage(UIImage(systemName: "minus.circle"), for: .normal)
        $0.tintColor = .darkText
    }
    
    lazy var editButton = UIButton().then {
        $0.setImage(UIImage(systemName: "pencil.circle"), for: .normal)
        $0.tintColor = .darkText
    }
    
    lazy var shareButton = UIButton().then {
        $0.setImage(UIImage(systemName: "square.and.arrow.up.circle"), for: .normal)
        $0.tintColor = .darkText
    }
    
    var viewModel: MemoDetailViewModel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setView()
        setConstraint()
    }
    
    func bindViewModel() {
        viewModel.title
            .drive(topTitleLabel.rx.text)
            .disposed(by: rx.disposeBag)
        
        viewModel.content
            .bind(to: contentLabel.rx.text)
            .disposed(by: rx.disposeBag)
        
        viewModel.date
            .bind(to: dateLabel.rx.text)
            .disposed(by: rx.disposeBag)
        
        backButton.rx.action = viewModel.performCancel()
        
        editButton.rx.action = viewModel.makeEditAction()
        
        shareButton.rx.action = viewModel.makeShareAction(self)
        
        deleteButton.rx.action = viewModel.makeDeleteAction()
    }
    
    func setView() {
        view.backgroundColor = .white
        view.addSubview(topTitleLabel)
        view.addSubview(backButton)
        view.addSubview(contentLabel)
        view.addSubview(dateLabel)
        view.addSubview(bottomButtonStackView)
        
        bottomButtonStackView.addArrangedSubview(deleteButton)
        bottomButtonStackView.addArrangedSubview(editButton)
        bottomButtonStackView.addArrangedSubview(shareButton)
    }
    
    func setConstraint() {
        topTitleLabel.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(view.layoutMarginsGuide.snp.top).offset(16)
        }
        
        backButton.snp.makeConstraints { make in
            make.height.equalTo(24)
            make.leading.equalToSuperview().offset(16)
            make.centerY.equalTo(topTitleLabel.snp.centerY)
        }
        
        contentLabel.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(16)
            make.trailing.equalToSuperview().offset(-16)
            make.top.equalTo(backButton.snp.bottom).offset(40)
        }
        
        dateLabel.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(16)
            make.trailing.equalToSuperview().offset(-16)
            make.top.equalTo(contentLabel.snp.bottom).offset(8)
        }
        
        bottomButtonStackView.snp.makeConstraints { make in
            make.trailing.equalToSuperview().offset(-16)
            make.bottom.equalTo(view.layoutMarginsGuide.snp.bottom).offset(-16)
        }
    }
}
