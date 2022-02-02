//
//  MemoListTableViewCell.swift
//  RxPracticeMemo
//
//  Created by Min-Su Kim on 2022/02/02.
//

import Foundation
import UIKit

class MemoListTableViewCell: UITableViewCell {
    
    let dateLabel = UILabel().then {
        $0.textColor = .lightGray
        $0.font = .systemFont(ofSize: 12, weight: .medium)
    }
    
    let contentLabel = UILabel().then {
        $0.textColor = .darkText
        $0.font = .systemFont(ofSize: 14, weight: .medium)
        $0.numberOfLines = 0
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        selectionStyle = .none
        setView()
        setConstraint()
    }
    
    func setView() {
        contentView.addSubview(dateLabel)
        contentView.addSubview(contentLabel)
    }
    
    func setConstraint() {
        dateLabel.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(16)
            make.trailing.equalToSuperview().offset(-16)
            make.top.equalToSuperview().offset(8)
        }
        
        contentLabel.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(16)
            make.trailing.equalToSuperview().offset(-16)
            make.top.equalTo(dateLabel.snp.bottom).offset(16)
            make.bottom.equalToSuperview().offset(-18)
        }
    }
}
