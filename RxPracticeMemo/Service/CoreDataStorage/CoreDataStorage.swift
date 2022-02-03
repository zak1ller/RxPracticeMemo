//
//  CoreDataStorage.swift
//  RxPracticeMemo
//
//  Created by Min-Su Kim on 2022/02/03.
//

import Foundation
import CoreData
import RxSwift
import RxCoreData

class CoreDataStorage: MemoStorageType {
    
    let modelName: String
    
    lazy var persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: self.modelName)
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()

    private var mainContext: NSManagedObjectContext {
        return persistentContainer.viewContext
    }
    
    init(modelName: String) {
        self.modelName = modelName
    }
    
    @discardableResult
    func createMemo(content: String) -> Observable<Memo> {
        let memo = Memo(content: content)

        do {
            _ = try mainContext.rx.update(memo)
            return Observable.just(memo)
        } catch {
            return Observable.error(error)
        }
    }
    
    @discardableResult
    func memoList() -> Observable<[MemoSectionModel]> {
        return mainContext.rx.entities(Memo.self, sortDescriptors: [NSSortDescriptor(key: "insertDate", ascending: false)])
            .map { results in [MemoSectionModel(model: 0, items: results)] }
    }
    
    @discardableResult
    func update(memo: Memo, content: String) -> Observable<Memo> {
        let updated = Memo(original: memo, updatedContent: content)
        
        do {
            _ = try mainContext.rx.update(updated)
            return Observable.just(updated)
        } catch {
            return Observable.error(error)
        }
    }
    
    @discardableResult
    func delete(memo: Memo) -> Observable<Memo> {
        do {
            try mainContext.rx.delete(memo)
            return Observable.just(memo)
        } catch {
            return Observable.error(error)
        }
    }
    
    
}
