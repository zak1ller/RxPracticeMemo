//
//  MemoDetailViewModel.swift
//  RxPracticeMemo
//
//  Created by Min-Su Kim on 2022/02/02.
//

import Foundation
import RxSwift
import RxCocoa
import Action

class MemoDetailViewModel: CommonViewModel {
    
    let cancelAction: CocoaAction
    
    init(title: String, sceneCoordinator: SceneCoordinationType, storage: MemoryStorage, cancelAction: CocoaAction? = nil) {
        self.cancelAction = CocoaAction {
            if let action = cancelAction {
                action.execute(())
            }
            return sceneCoordinator.close(animated: true).asObservable().map { _ in }
        }
        super.init(title: title, sceneCoordinator: sceneCoordinator, storage: storage)
    }
    
    
}
