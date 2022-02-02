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
            listVC.modalPresentationStyle = .fullScreen
            listVC.bind(viewModel: memoListViewModel)
            return listVC
        case .detail(let memoDetailViewModel):
            var detailVC = MemoDetailViewController()
            detailVC.modalPresentationStyle = .fullScreen
            detailVC.bind(viewModel: memoDetailViewModel)
            return detailVC
        case .compose(let memoComposeViewModel):
            var composeVC = MemoComposeViewController()
            composeVC.modalPresentationStyle = .fullScreen
            composeVC.bind(viewModel: memoComposeViewModel)
            return composeVC
        }
    }
}
