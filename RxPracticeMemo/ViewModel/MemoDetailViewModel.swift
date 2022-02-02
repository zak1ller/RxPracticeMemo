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
    
    let memo: Memo
    
    private var formatter: DateFormatter = {
        let f = DateFormatter()
        f.locale = Locale(identifier: "ko_kr")
        f.dateStyle = .medium
        f.timeStyle = .medium
        return f
    }()
    
    var content: BehaviorSubject<String>
    var date: BehaviorSubject<String>

    init(memo: Memo, title: String, sceneCoordinator: SceneCoordinationType, storage: MemoStorageType) {
        self.memo = memo
        
        content = BehaviorSubject<String>(value: memo.content)
        
        date = BehaviorSubject<String>(value: formatter.string(from: memo.insertDate))
        
        super.init(title: title, sceneCoordinator: sceneCoordinator, storage: storage)
    }
    
    func performCancel() -> CocoaAction {
        return CocoaAction { _ in
            return self.sceneCoordinator.close(animated: true).asObservable().map { _ in }
        }
    }
    
    func performUpdate(memo: Memo) -> Action<String, Void> {
        return Action { input in
            self.storage.update(memo: memo, content: input)
                .map { $0.content }
                .bind(onNext: { self.content.onNext($0) })
                .disposed(by: self.rx.disposeBag)

            return Observable.empty()
        }
    }
    
    func makeEditAction() -> CocoaAction {
        return CocoaAction { _ in
            let composeViewModel = MemoComposeViewModel(title: "편집", content: self.memo.content, sceneCoodinator: self.sceneCoordinator, storage: self.storage, saveAction: self.performUpdate(memo: self.memo))
            
            let composeScene = Scene.compose(composeViewModel)
            
            return self.sceneCoordinator.transition(to: composeScene, using: .present, animated: true)
                .asObservable()
                .map { _ in }
        }
    }
    
    func makeShareAction(_ vc: UIViewController) -> CocoaAction {
        return CocoaAction { _ in
            let activityVC = UIActivityViewController(activityItems: [self.memo], applicationActivities: nil)
            vc.present(activityVC, animated: true, completion: nil)
            return Observable.empty()
        }
    }
    
    func makeDeleteAction() -> CocoaAction {
        return Action { input in
            self.storage.delete(memo: self.memo)
            return self.sceneCoordinator.close(animated: true)
                .asObservable()
                .map { _ in }
            
        }
    }
}
