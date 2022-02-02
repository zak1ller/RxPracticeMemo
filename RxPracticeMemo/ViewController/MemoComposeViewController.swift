//
//  MemoComposeViewController.swift
//  RxPracticeMemo
//
//  Created by Min-Su Kim on 2022/02/02.
//

import UIKit
import RxSwift
import RxCocoa
import Action
import NSObject_Rx

class MemoComposeViewController: UIViewController, ViewModelBindableType {

    lazy var topTitleLabel = UILabel().then {
        $0.textColor = UIColor.darkText
        $0.textAlignment = .center
        $0.font = .systemFont(ofSize: 16, weight: .bold)
    }
    
    lazy var backButton = UIButton().then {
        $0.setImage(UIImage(systemName: "arrow.backward"), for: .normal)
        $0.tintColor = .darkText
    }
    
    lazy var saveButton = UIButton().then {
        $0.setTitle("저장", for: .normal)
        $0.setTitleColor(.darkText, for: .normal)
        $0.titleLabel?.font = .systemFont(ofSize: 14, weight: .bold)
    }
    
    lazy var contentTextView = UITextView().then {
        $0.textColor = .darkText
        $0.font = .systemFont(ofSize: 14, weight: .medium)
    }
    
    var viewModel: MemoComposeViewModel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setView()
        setConstraint()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        contentTextView.becomeFirstResponder()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        if contentTextView.isFirstResponder {
            contentTextView.resignFirstResponder()
        }
    }
    
    func bindViewModel() {
        viewModel.title
            .drive(topTitleLabel.rx.text)
            .disposed(by: rx.disposeBag)
        
        viewModel.initialText
            .drive(contentTextView.rx.text)
            .disposed(by: rx.disposeBag)
        
        backButton.rx.action = viewModel.cancelAction
        
        saveButton.rx.tap
            .throttle(.microseconds(500), scheduler: MainScheduler.instance)
            .withLatestFrom(contentTextView.rx.text.orEmpty)
            .bind(to: viewModel.saveAction.inputs)
            .disposed(by: rx.disposeBag)
    }
    
    func setView() {
        view.backgroundColor = .white
        view.addSubview(topTitleLabel)
        view.addSubview(backButton)
        view.addSubview(saveButton)
        view.addSubview(contentTextView)
    }
    
    func setConstraint() {
        topTitleLabel.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(view.layoutMarginsGuide.snp.top).offset(16)
        }
        
        backButton.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(16)
            make.centerY.equalTo(topTitleLabel.snp.centerY)
        }
        
        saveButton.snp.makeConstraints { make in
            make.height.equalTo(24)
            make.trailing.equalToSuperview().offset(-16)
            make.centerY.equalTo(topTitleLabel.snp.centerY)
        }
        
        contentTextView.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(16)
            make.trailing.equalToSuperview().offset(-16)
            make.top.equalTo(backButton.snp.bottom).offset(40)
            make.bottom.equalToSuperview()
        }
    }
   

}
