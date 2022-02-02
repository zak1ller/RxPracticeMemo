//
//  MemoComposeViewModel.swift
//  RxPracticeMemo
//
//  Created by Min-Su Kim on 2022/02/02.
//

import Foundation
import RxSwift
import RxCocoa
import Action

class MemoComposeViewModel: CommonViewModel {
    private let content: String?
    
    var initialText: Driver<String?> {
        return Observable.just(content).asDriver(onErrorJustReturn: nil)
    }
    
    let saveAction: Action<String, Void>
    let cancelAction: CocoaAction
    
    init(title: String, content: String? = nil, sceneCoodinator: SceneCoordinationType, storage: MemoStorageType, saveAction: Action<String, Void>? = nil, cancelAction: CocoaAction? = nil) {
        self.content = content
        self.saveAction = Action<String, Void> { input in
            if let action = saveAction {
                action.execute(input)
            }
            return sceneCoodinator.close(animated: true).asObservable().map { _ in }
        }
        self.cancelAction = CocoaAction {
            if let action = cancelAction {
                action.execute(())
            }
            return sceneCoodinator.close(animated: true).asObservable().map { _ in }
        }
        super.init(title: title, sceneCoordinator: sceneCoodinator, storage: storage)
    }
}


