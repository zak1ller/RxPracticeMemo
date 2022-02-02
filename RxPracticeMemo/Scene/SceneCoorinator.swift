//
//  SceneCoorinator.swift
//  RxPracticeMemo
//
//  Created by Min-Su Kim on 2022/02/02.
//

import Foundation
import RxSwift
import RxCocoa

class SceneCoordinator: SceneCoordinationType {
    
    private let bag = DisposeBag()
    
    private var window: UIWindow
    var currentVC: UIViewController
    
    required init(window: UIWindow) {
        self.window = window
        currentVC = window.rootViewController!
    }
    
    @discardableResult
    func transition(to scene: Scene, using style: TransitionStyle, animated: Bool) -> Completable {
        let subject = PublishSubject<Never>()
        
        let target = scene.instantiate()
        
        switch style {
        case .root:
            currentVC = target
            window.rootViewController = target
            subject.onCompleted()
        case .present:
            currentVC.present(target, animated: animated) {
                subject.onCompleted()
            }
            currentVC = target
            subject.onCompleted()
        }
        
        return subject.asCompletable()
    }
    
    @discardableResult
    func close(animated: Bool) -> Completable {
        return Completable.create { [unowned self] completable in
            if let presenttingVC = self.currentVC.presentingViewController {
                self.currentVC.dismiss(animated: animated) {
                    self.currentVC = presenttingVC
                    completable(.completed)
                }
            }
            return Disposables.create()
        }
    }
}
