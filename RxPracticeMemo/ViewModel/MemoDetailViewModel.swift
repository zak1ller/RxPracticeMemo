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

    init(memo: Memo, title: String, sceneCoordinator: SceneCoordinationType, storage: MemoryStorage) {
        self.memo = memo
        
        content = BehaviorSubject<String>(value: memo.content)
        
        date = BehaviorSubject<String>(value: formatter.string(from: memo.insertDate))
        
        super.init(title: title, sceneCoordinator: sceneCoordinator, storage: storage)
    }
}
