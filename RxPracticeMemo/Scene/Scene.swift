//
//  Scene.swift
//  RxPracticeMemo
//
//  Created by Min-Su Kim on 2022/02/02.
//

import Foundation
import UIKit

enum Scene {
    case list(MemoListViewModel)
    case detail(MemoDetailViewModel)
    case compose(MemoComposeViewModel)
}

extension Scene {
    func instantiate() -> UIViewController {
        switch self {
        case .list(let memoListViewModel):
            var listVC = MemoListViewController()
            listVC.bind(viewModel: memoListViewModel)
            return listVC
        case .detail(let memoDetailViewModel):
            var detailVC = MemoDetailViewController()
            detailVC.bind(viewModel: memoDetailViewModel)
            return detailVC
        case .compose(let memoComposeViewModel):
            var composeVC = MemoComposeViewController()
            composeVC.bind(viewModel: memoComposeViewModel)
            return composeVC
        }
    }
}
